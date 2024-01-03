//
//  CustomNavBarView.swift
//  CustomNavigationView
//
//  Created by John on 21/12/23.
//

import SwiftUI

struct CustomNavBarView: View {
    @State  var isBackButtonhidden :Bool = false
    @State  var isBackButtonTextHidden :Bool = false
    @State  var isCentreTittleImagehidden : Bool = true
    @State  var isTittlehidden : Bool = false
    @State  var isSubTittleHidden : Bool = false
    @State  var isTrallingImageOneHidden :Bool = false
    @State  var isTrallingImageTwoHidden :Bool = false
    @State  var isLeadingButtonHidden : Bool = true
    @State  var  isbackButtonImage : Image  = Image(systemName: "chevron.left")
    @State  var leadingButtonimage :Image = Image("titleImg")
    @State  var lbBackButton :String = "Back"
    @State  var titleFont: CGFloat  =  30
    @State  var subTitleFont: CGFloat  =  22
    @State  var backButtonTextFont: CGFloat = 16
    @State  var lbTitile :String = "Title"
    @State  var lbSubTitle :String = "SubTitle"
    @State  var isCentreTittleImage :Image = Image("titleImg")
    @State  var isTrallingImageSecond :Image = Image("titleImg")
    @State  var isTrallingImageFirst :Image = Image("titleImg")
    @State  var backgroundColor :Color = Color.blue
    @State  var backgroundimage :Image = Image("nav")
    @State  var isBackGroundImageSet :Bool = false
    @State   var backButtonImageSize: CGSize = CGSize(width: 12, height: 12)
    @State   var leadingButtonImageSize: CGSize = CGSize(width: 40, height: 40)
    @State  var centerTitleImageSize: CGSize = CGSize(width: 40, height: 40)
    @State  var firstTrailingImageSize: CGSize = CGSize(width: 40, height: 40)
    @State  var secondTrailingImageSize: CGSize = CGSize(width: 40, height: 40)
    @State  var backButtonAction: (() -> Void)? = nil
    @State  var leadingButtonCallBack: (() -> Void)? = nil
    @State  var tralingFirstButtonCallBack: (() -> Void)? = nil
    @State  var tralingSecondButtonCallBack: (() -> Void)? = nil

        @Environment(\.presentationMode) var presentationMode 
    
    func dismissAction() {
            presentationMode.wrappedValue.dismiss()
        }
    

    var body: some View {

            HStack{
                ZStack(content: {
                    
                    Button(action: {
                        (backButtonAction ?? dismissAction)()

                    },
                           label: {
                        HStack{
                            isbackButtonImage
                                .frame(width: min(backButtonImageSize.width, 40), height: min(backButtonImageSize.height, 40))
                            
                            Text(lbBackButton)
                                .lineLimit(1)
                                .font(.system(size: min(backButtonTextFont, 22)))
                                .isHidden(isBackButtonTextHidden)
                            
                        }
                    }).isHidden(isBackButtonhidden)
                    
                    Button(action: {
                        leadingButtonCallBack!()
                    },
                           label: {
                        HStack{
                            leadingButtonimage.resizable()
                                .frame(width: min(leadingButtonImageSize.width, 40), height: min(leadingButtonImageSize.height, 40))
                        }
                    }).isHidden((isBackButtonhidden == false || isLeadingButtonHidden == true))
                    
                    
                    
                })
                
                Spacer()
                VStack(spacing: 4, content: {
                    isCentreTittleImage
                        .resizable()
                        .frame(width: min(centerTitleImageSize.width, 40), height: min(centerTitleImageSize.height, 40), alignment: .center).isHidden(isCentreTittleImagehidden,remove: isCentreTittleImagehidden)
                    
                    Text(lbTitile).font( .system(size: min(titleFont, 30)))
                        .isHidden(((isCentreTittleImagehidden == false || isTittlehidden == true) ),remove: (isCentreTittleImagehidden == false || isTittlehidden == true) )
                    
                    
                    Text(lbSubTitle).font(.system(size: min(subTitleFont, 28))).isHidden(isSubTittleHidden)
                    
                })
                .padding(.leading, 32)
                
                Spacer()
                
                Button(action: {
                    tralingSecondButtonCallBack!()
                },
                       label: {
                    isTrallingImageSecond.resizable()
                        .frame(width: min(secondTrailingImageSize.width, 40), height: min(secondTrailingImageSize.height, 40), alignment: .center)
                }).padding(.trailing, 4).isHidden(isTrallingImageTwoHidden)
                
                
                Button(action: {
                    tralingFirstButtonCallBack!()
                },
                       label: {
                    isTrallingImageFirst.resizable()
                        .frame(width:  min(firstTrailingImageSize.width, 40), height: min(firstTrailingImageSize.height, 40), alignment: .center).isHidden(isTrallingImageOneHidden)
                })
                
                
            }
            .padding()
            .accentColor(.white)
            .foregroundColor(.white)
            
            .background(
                isBackGroundImageSet == true ?
                AnyView(backgroundimage.resizable().ignoresSafeArea()) :
                    AnyView(backgroundColor.ignoresSafeArea())
            )
       
           
     
            

        
    }
    
    
}

#Preview {
    VStack{
        CustomNavBarView()
     
    }
    
}


extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
