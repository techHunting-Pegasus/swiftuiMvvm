
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
