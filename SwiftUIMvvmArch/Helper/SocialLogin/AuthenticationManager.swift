import SwiftUI
import Firebase
import GoogleSignIn
import AuthenticationServices
import FBSDKLoginKit

class AuthenticationManager: NSObject, ObservableObject {
    
    @Published var isAuthenticated = false

    override init() {
        super.init()
        FirebaseApp.configure()
    }
    
    // MARK: - Apple Login
    func appleLogin(completion: @escaping (Result<Bool, Error>) -> Void) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    // MARK: - Google Login
    func googleLogin(presentingViewController: UIViewController, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { [weak self] user, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            

            guard let authentication = user?.authentication, let idToken = authentication.idToken else {
                completion(.failure(NSError(domain: "GoogleSignIn", code: -1, userInfo: nil)))
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            self?.authenticateWithFirebase(credential: credential, completion: completion)
        }
    }

    // MARK: - Facebook Login
    func facebookLogin(completion: @escaping (Result<Bool, Error>) -> Void) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["email"], from: nil) { [weak self] result, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let accessToken = AccessToken.current?.tokenString else {
                completion(.failure(NSError(domain: "FacebookLogin", code: -1, userInfo: nil)))
                return
            }

            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            self?.authenticateWithFirebase(credential: credential, completion: completion)
        }
    }

    // MARK: - Common method to handle authentication with Firebase
    private func authenticateWithFirebase(credential: AuthCredential, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            self?.isAuthenticated = true
            completion(.success(true))
        }
    }
}

// MARK: - Extensions for Apple Login
extension AuthenticationManager: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential, let appleIDToken = appleIDCredential.identityToken, let idTokenString = String(data: appleIDToken, encoding: .utf8) {
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nil)
            authenticateWithFirebase(credential: credential) { result in
                // Handle result
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
