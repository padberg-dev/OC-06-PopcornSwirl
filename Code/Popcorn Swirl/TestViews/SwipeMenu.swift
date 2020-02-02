//
//  SwipeMenu.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 17.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI

struct SwipeMenu: View {
    @State var size: CGFloat = UIScreen.main.bounds.height - 120
    
    var body: some View {
        
        ZStack {
            
            Color.orange
                .edgesIgnoringSafeArea(.all)
            
            Swipe()
                .cornerRadius(20)
                .padding(15)
                .offset(y: size)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            let transHeight = gesture.translation.height
                            if transHeight > 0 {
                                
                                self.size = transHeight
                            } else {
                                
                                let temp = UIScreen.main.bounds.height - 130
                                self.size = temp + transHeight
                            }
                    }
                    .onEnded { gesture in

                        let transHeight = gesture.translation.height
                        if transHeight > 0 {
                            if transHeight > 200 {
                                
                                self.size = UIScreen.main.bounds.height - 130
                            } else {
                                
                                self.size = 15
                            }
                        } else {

                            if transHeight < 200 {
                                
                                self.size = 15
                            } else {
                                
                                self.size = UIScreen.main.bounds.height - 130
                            }
                        }
                    }
            )
                .animation(.spring())
            
        }
    }
}

struct SwipeMenu_Previews: PreviewProvider {
    static var previews: some View {
        SwipeMenu()
    }
}

struct Swipe: View {
    var body: some View {
        VStack {
            VStack {
                Text("Swipe up to see more")
                    .fontWeight(.heavy)
                    .padding([.top, .bottom], 15)
            }
            
            HStack {
                Spacer()
                Text("Hello Top")
                    .fontWeight(.heavy)
                    .padding()
            }
            
            
            
            Spacer()
            
            Text("Hello Bottom")
                .fontWeight(.heavy)
                .padding()
        }
        .background(Color.white)
    }
}
