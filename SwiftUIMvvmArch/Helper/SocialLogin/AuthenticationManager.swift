import SwiftUI
import Firebase
import GoogleSignIn
import AuthenticationServices
import FBSDKLoginKit
import CryptoKit

class AuthenticationManager: NSObject, ObservableObject {
    
    @Published var isAuthenticated = false
    var currentNonce: String?
     var appleLoginCompletion : ((SocialSignInModel?, Bool? , Error?) -> Void)?

    override init() {
        super.init()
//        FirebaseApp.configure()
    }
    
    // MARK: - Apple Login
    func appleLogin(completion: @escaping (SocialSignInModel?, Bool?, Error?) -> Void) {
        let nonce = randomNonceString()
        currentNonce = nonce
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
        self.appleLoginCompletion = completion
    }

    // MARK: - Google Login
    func googleLogin(completion: @escaping (SocialSignInModel?, Bool? , Error?) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { [weak self] user, error in
            if let error = error {
                completion(nil, false, error)
                return
            }
            

            guard let authentication = user?.user, let idToken = authentication.idToken?.tokenString else {
            completion(nil, false, error)
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken.tokenString)
            self?.authenticateWithFirebase(credential: credential, completion: completion)
        }
    }

    // MARK: - Facebook Login
    func facebookLogin(completion: @escaping (SocialSignInModel?, Bool? , Error?) -> Void) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: nil) { [weak self] result, error in
            if let error = error {
                completion(nil, false, error)
                return
            }

            guard let accessToken = AccessToken.current?.tokenString else {
                completion(nil, false, error)
                return
            }

            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            self?.authenticateWithFirebase(credential: credential, completion: completion)
        }
    }

    // MARK: - Common method to handle authentication with Firebase
    private func authenticateWithFirebase(credential: AuthCredential, completion: @escaping (SocialSignInModel?, Bool? , Error?) -> Void) {
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            if let error = error {
                completion(nil, false, error)
                return
            }
            self?.isAuthenticated = true
            if let authuser = authResult{
                let model = SocialSignInModel()
                model.email = authuser.user.email
                model.firstName = authuser.user.displayName
                model.id = authuser.user.uid
                model.profileURl = "\(authuser.user.photoURL)"
                completion(model, true, nil)
            }
           
        }
    }
    @available(iOS 13, *)
       private func sha256(_ input: String) -> String {
         let inputData = Data(input.utf8)
         let hashedData = SHA256.hash(data: inputData)
         let hashString = hashedData.compactMap {
           String(format: "%02x", $0)
         }.joined()

         return hashString
       }
    private func randomNonceString(length: Int = 32) -> String {
          precondition(length > 0)
          let charset: [Character] =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
          var result = ""
          var remainingLength = length

          while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
              var random: UInt8 = 0
              let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
              if errorCode != errSecSuccess {
                fatalError(
                  "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                )
              }
              return random
            }

            randoms.forEach { random in
              if remainingLength == 0 {
                return
              }

              if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
              }
            }
          }

          return result
        }
}

// MARK: - Extensions for Apple Login
extension AuthenticationManager: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential, let appleIDToken = appleIDCredential.identityToken, let idTokenString = String(data: appleIDToken, encoding: .utf8) {
            guard let nonce = currentNonce else {
                          fatalError("Invalid state: A login callback was received, but no login request was sent.")
                      }
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            authenticateWithFirebase(credential: credential) { result,status,error  in
                // Handle result
                self.appleLoginCompletion!(result,status,error)
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error
        self.appleLoginCompletion!(nil, false,error)
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
