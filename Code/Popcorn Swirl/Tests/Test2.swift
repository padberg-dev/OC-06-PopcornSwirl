//
//  Test2.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 26.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI

struct Test2: View {

    @State private var offset: CGFloat = 0

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {

                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Rectangle()
                            .frame(width: 0, height: 40)
                        Text("LOLITA")
                            .font(.headline)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("aslf k asdfl adsfasd fa sdf")
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                }

                .content.offset(y: self.offset)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation.height
                    }
//                .onEnded({ gesture in
//                    withAnimation {
//                        self.offset = 0
//                    }
//                })
                )
            }
        }
    }
}

struct Test2_Previews: PreviewProvider {
    static var previews: some View {
        Test2()
    }
}
