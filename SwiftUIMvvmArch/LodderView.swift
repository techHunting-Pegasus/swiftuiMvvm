//
//  LodderView.swift
//  SwiftUIMvvmArch
//
//  Created by John on 09/10/23.
//


import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var animationName: String
    var loopMode: LottieLoopMode = .loop
    var animationSpeed: CGFloat = 1.0
    
    let animationView = LottieAnimationView()
    
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        view.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        let animation = LottieAnimation.named(animationName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.layer.zPosition = 9999999
        
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        animationView.play()
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct LoaderView :View{
    @Binding var isShowing: Bool

   

    var body: some View {
        ZStack {

            
            if isShowing {

 
                LottieView(animationName: "animation_lnimmxl6.json")
                    .frame(width: 50, height: 50)
                                           
           
            }
        }
   
    }

}
