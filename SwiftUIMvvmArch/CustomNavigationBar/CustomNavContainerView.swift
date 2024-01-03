//
//  CustomNavContainerView.swift
//  CustomNavigationView
//
//  Created by John on 26/12/23.
//

import SwiftUI

struct CustomNavContainerView<Content>: View where Content: View {
    var isBackButtonhidden :Bool
    var isBackButtonTextHidden :Bool
    var isCentreTittleImagehidden : Bool
    var isTittlehidden : Bool
    var isSubTittleHidden : Bool
    var isTrallingImageOneHidden :Bool
    var isTrallingImageTwoHidden :Bool
    var isLeadingButtonHidden : Bool
    var  isbackButtonImage : Image
    var leadingButtonimage :Image
    var lbBackButton :String
    var titleFont: CGFloat
    var subTitleFont: CGFloat
    var backButtonTextFont: CGFloat
    var lbSubTitle :String
    var isCentreTittleImage :Image
    var isTrallingImageSecond :Image
    var isTrallingImageFirst :Image
    var backgroundColor :Color
    var backgroundimage :Image
    var isBackGroundImageSet :Bool
    var backButtonImageSize: CGSize
    var leadingButtonImageSize: CGSize
    var centerTitleImageSize: CGSize
    var firstTrailingImageSize: CGSize
    var secondTrailingImageSize: CGSize
    var backButtonAction: (() -> Void)?
    var leadingButtonCallBack: (() -> Void)?
    var tralingFirstButtonCallBack: (() -> Void)?
    var tralingSecondButtonCallBack: (() -> Void)?

    let content : Content
    var lbTitile :String = "Title"

    init(
           @ViewBuilder content: @escaping () -> Content,
           lbTitle: String = "Title",
           isBackButtonHidden: Bool = false,
           isBackButtonTextHidden: Bool = false,
           isCentreTitleImageHidden: Bool = true,
           isTitleHidden: Bool = false,
           isSubTitleHidden: Bool = false,
           isTrailingImageOneHidden: Bool = false,
           isTrailingImageTwoHidden: Bool = false,
           isLeadingButtonHidden: Bool = true,
           backButtonImage: Image = Image(systemName: "chevron.left"),
           leadingButtonImage: Image = Image("titleImg"),
           lbBackButton: String = "Back",
           titleFont: CGFloat = 30,
           subTitleFont: CGFloat = 22,
           backButtonTextFont: CGFloat = 16,
           lbSubTitle: String = "SubTitle",
           isCentreTitleImage: Image = Image("titleImg"),
           isTrailingImageSecond: Image = Image("titleImg"),
           isTrailingImageFirst: Image = Image("titleImg"),
           backgroundColor: Color = Color.blue,
           backgroundImage: Image = Image("nav"),
           isBackgroundImageSet: Bool = false,
           backButtonImageSize: CGSize = CGSize(width: 12, height: 12),
           leadingButtonImageSize: CGSize = CGSize(width: 40, height: 40),
           centerTitleImageSize: CGSize = CGSize(width: 40, height: 40),
           firstTrailingImageSize: CGSize = CGSize(width: 40, height: 40),
           secondTrailingImageSize: CGSize = CGSize(width: 40, height: 40),
           backButtonAction: (() -> Void)? = nil,
           leadingButtonCallBack: (() -> Void)? = nil,
           trailingFirstButtonCallBack: (() -> Void)? = nil,
           trailingSecondButtonCallBack: (() -> Void)? = nil
       ) {
           self.content = content()
           self.lbTitile = lbTitle
           self.isBackButtonhidden = isBackButtonHidden
           self.isBackButtonTextHidden = isBackButtonTextHidden
           self.isCentreTittleImagehidden = isCentreTitleImageHidden
           self.isTittlehidden = isTitleHidden
           self.isSubTittleHidden = isSubTitleHidden
           self.isTrallingImageOneHidden = isTrailingImageOneHidden
           self.isTrallingImageTwoHidden = isTrailingImageTwoHidden
           self.isLeadingButtonHidden = isLeadingButtonHidden
           self.isbackButtonImage = backButtonImage
           self.leadingButtonimage = leadingButtonImage
           self.lbBackButton = lbBackButton
           self.titleFont = titleFont
           self.subTitleFont = subTitleFont
           self.backButtonTextFont = backButtonTextFont
           self.lbSubTitle = lbSubTitle
           self.isCentreTittleImage = isCentreTitleImage
           self.isTrallingImageSecond = isTrailingImageSecond
           self.isTrallingImageFirst = isTrailingImageFirst
           self.backgroundColor = backgroundColor
           self.backgroundimage = backgroundImage
           self.isBackGroundImageSet = isBackgroundImageSet
           self.backButtonImageSize = backButtonImageSize
           self.leadingButtonImageSize = leadingButtonImageSize
           self.centerTitleImageSize = centerTitleImageSize
           self.firstTrailingImageSize = firstTrailingImageSize
           self.secondTrailingImageSize = secondTrailingImageSize
           self.backButtonAction = backButtonAction
           self.leadingButtonCallBack = leadingButtonCallBack
           self.tralingFirstButtonCallBack = trailingFirstButtonCallBack
           self.tralingSecondButtonCallBack = trailingSecondButtonCallBack
       }

    
    var body: some View {
        VStack(spacing: 0, content: {
            CustomNavBarView(isBackButtonhidden: isBackButtonhidden, isBackButtonTextHidden: isBackButtonTextHidden, isCentreTittleImagehidden: isCentreTittleImagehidden, isTittlehidden: isTittlehidden, isSubTittleHidden: isSubTittleHidden, isTrallingImageOneHidden: isTrallingImageOneHidden, isTrallingImageTwoHidden: isTrallingImageTwoHidden, isLeadingButtonHidden: isLeadingButtonHidden, isbackButtonImage: isbackButtonImage, leadingButtonimage: leadingButtonimage, lbBackButton: lbBackButton, titleFont: titleFont, subTitleFont: subTitleFont, backButtonTextFont: backButtonTextFont, lbTitile: lbTitile, lbSubTitle: lbSubTitle, isCentreTittleImage: isCentreTittleImage, isTrallingImageSecond: isTrallingImageSecond, isTrallingImageFirst: isTrallingImageFirst, backgroundColor: backgroundColor, backgroundimage: backgroundimage, isBackGroundImageSet: isBackGroundImageSet, backButtonImageSize: backButtonImageSize, leadingButtonImageSize: leadingButtonImageSize, centerTitleImageSize: centerTitleImageSize, firstTrailingImageSize: firstTrailingImageSize, secondTrailingImageSize: secondTrailingImageSize, backButtonAction: backButtonAction, leadingButtonCallBack: leadingButtonCallBack, tralingFirstButtonCallBack: tralingFirstButtonCallBack, tralingSecondButtonCallBack: tralingSecondButtonCallBack)
            content
                .frame(maxWidth: .infinity,maxHeight: .infinity)
        }).navigationBarHidden(true)
            
        
    }
}

#Preview {

    CustomNavContainerView(content: {
        ZStack{
                   Color.red.ignoresSafeArea()
               }
    })
}
