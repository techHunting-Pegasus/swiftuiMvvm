
ussage of the custom navigation  in swiftui
**************************************************************************

use the CustomNavView with replacement of NavigationView:-
is this the stack whcih can ad the screen in this view

       struct tabviews1: View {
    @State var isSecondScreen: Bool = false
    var body: some View {
    
            CustomNavView(content: {
                ZStack(content: {
                    Color.green.opacity(0.3)
                    VStack{
                        Button {
                            isSecondScreen = true
                        } label: {
                            Text("seconfscreen")
                        }
                        Text("tabviews1")
                        NavigationLink("",destination: SecondView() ,isActive: $isSecondScreen)
                    }
                })
                      
                  }, isBackButtonHidden: true)
       
    }
}

**************************************************************************
after that use the next screeen use this  CustomNavContainerView

 CustomNavContainerView(content: {
            ZStack{
               
                Button {
                    isThirdScreen = true
                } label: {
                    Text("third screen")
                }
                NavigationLink("",destination: ThirdView() , isActive: $isThirdScreen)
            }
        })
********************************************


use these variable with  for ussage :-

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
