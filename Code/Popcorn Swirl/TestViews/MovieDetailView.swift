//
//  MovieDetailView.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 26.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI
import Combine

struct MovieDetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    // CAST
    // REVIEWS
    // VIDEO
    // SIMMILAR
    
    @State var moreInfo: Bool = false
    @State var isShowingReviews: Bool = false
    
    @State var shouldShowComment: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        ZStack(alignment: .topLeading) {

                            HeaderView(title: self.viewModel.result?.original_title ?? "", orgTitle: self.viewModel.result?.title ?? "", image: self.viewModel.backdropImage)
                                .frame(width: UIScreen.main.bounds.width, height: 260)
                                .background(Color.red)
                        }
                        
                        ZStack(alignment: .topLeading) {
                            
                            
                            HStack {
                                self.viewModel.iconImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                                    .cornerRadius(12)
                                    .shadow(color: Color(white: 0.45), radius: 36)
                                    .shadow(radius: 12)
                                    .padding(.horizontal, 20)
                                
                                Spacer()
                            }
                            .offset(y: -90)
                            
                            HStack(spacing: 2) {
                                
                                Rectangle()
                                    .frame(width: 160, height: 20)
                                    .foregroundColor(.clear)
                                
                                Spacer()
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(self.viewModel.getGenres().joined(separator: " | "))
                                        .font(Font.system(size: 12, weight: .light))
                                        .lineLimit(1)
                                        .foregroundColor(.black)
                                        .padding(.vertical, 6)
                                    
                                    ScoreView(score: CGFloat(self.viewModel.result?.vote_average ?? 0))
                                        .frame(height: 30)
                                    
                                    HStack(spacing: 0) {
                                        Spacer()
                                        
                                        Text("Based on ".uppercased())
                                            .font(Font.system(size: 6, weight: .light))
                                        
                                        Text(String(self.viewModel.result?.vote_count ?? 0))
                                            .font(Font.system(size: 6, weight: .medium))
                                        
                                        Text(" votes".uppercased())
                                            .font(Font.system(size: 6, weight: .light))
                                        
                                        Spacer()
                                    }
                                    .padding(.top, -3)
                                    .padding(.bottom, 8)
                                    
                                    HStack {
                                        Text("Original Lang: \(self.viewModel.result?.original_language ?? "?")")
                                            .font(Font.system(size: 10, weight: .light))
                                            .padding(.bottom, 3)
                                        
                                        Spacer()
                                        
                                        Text("(\(self.viewModel.getCountries().joined(separator: ", ")))")
                                            .font(Font.system(size: 10, weight: .light))
                                            .padding(.trailing, 24)
                                    }
                                    HStack(spacing: 0) {
                                        Text("BUDGET:   ")
                                            .font(Font.system(size: 8, weight: .ultraLight))
                                        
                                        Text(self.viewModel.getBudget())
                                            .font(Font.system(size: 8, weight: .regular))
                                        
                                        Spacer()
                                        
                                        Text(self.viewModel.result?.release_date ?? "")
                                            .font(Font.system(size: 10, weight: .light))
                                            .padding(.trailing, 24)
                                    }
                                    
                                    HStack(spacing: 0) {
                                        Text("REVENUE: ")
                                            .font(Font.system(size: 8, weight: .ultraLight))
                                        
                                        Text(self.viewModel.getRevenue())
                                            .font(Font.system(size: 8, weight: .regular))
                                        
                                        Spacer()
                                        
                                        Text("\(self.viewModel.result?.runtime ?? 0) min")
                                            .font(Font.system(size: 10, weight: .light))
                                            .padding(.trailing, 24)
                                    }
                                }
                            }
                        }
                        //                    .background(Color.red)
                        
                        VStack(spacing: 0) {
                            
                            if self.moreInfo {
                                Text(self.viewModel.result?.overview ?? "")
                                    .font(Font.system(size: 14, weight: .light))
                                    .multilineTextAlignment(.leading)
                                    .animation(.default)
                                    .padding(.top, 18)
                                    .padding(.horizontal, 24)
                            } else {
                                Text(self.getOverview())
                                    .font(Font.system(size: 14, weight: .light))
                                    .multilineTextAlignment(.leading)
                                    .animation(.default)
                                    .padding(.top, 18)
                                    .padding(.horizontal, 24)
                            }
                            
                            if (self.viewModel.result?.overview?.count ?? 0) >= 300 {
                                Button(action: {
                                    self.moreInfo.toggle()
                                }) {
                                    Text(self.moreInfo ? "HIDE" : "SHOW MORE")
                                        .font(Font.system(size: 10, weight: .medium))
                                }
                                .padding(.top, 2)
                                .padding(.bottom, 10)
                            }
                            
                            HStack {
                                
                                Text("Full Cast")
                                    .font(Font.system(size: 16, weight: .medium))
                                    .padding(.horizontal, 24)
                                
                                Spacer()
                            }
                            .frame(height: 40)
                            .background(Color.hex("F8F8F8"))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(0..<self.viewModel.casts.count, id: \.self) {
                                        PortraitView(cast: self.viewModel.casts[$0], image: self.viewModel.castsImage[$0])
                                    }
                                }
                                .frame(height: 120)
                                .padding(.horizontal, 24)
                            }
                            
                            HStack {
                                
                                Text("Reviews (\(self.viewModel.reviews.count))")
                                    .font(Font.system(size: 16, weight: .medium))
                                    .padding(.leading, 24)
                                
                                Spacer()
                                
                                if self.viewModel.reviews.count > 0 {
                                    
                                    Button(action: {
                                        self.isShowingReviews.toggle()
                                    }) {
                                        Text("SHOW ALL REVIEWS")
                                            .font(Font.system(size: 10, weight: .medium))
                                            .padding(.trailing, 24)
                                            .sheet(isPresented: self.$isShowingReviews) {
                                                ReviewsView(reviews: self.viewModel.reviews, moreInfo: Array(repeating: false, count: self.viewModel.reviews.count))
                                        }
                                    }
                                }
                            }
                            .frame(height: 40)
                            .background(Color.hex("F8F8F8"))
                            
                            HStack {
                                GeometryReader { proxy in
                                    Path{ path in
                                        path.move(to: CGPoint(x: 0, y: 0))
                                        path.addLine(to: CGPoint(x: proxy.size.width, y: 0))
                                    }
                                    .stroke(style: StrokeStyle( lineWidth: 0.5, dash: [2]))
                                    .foregroundColor(Color.hex("979797").opacity(0.4))
                                }
                            }
                            .background(Color.hex("F8F8F8"))
                            .frame(height: 1)
                            .opacity(self.viewModel.checkedButtons[2] ? 0 : 1)
                            .animation(.spring())
                            
                            HStack {
                                
                                Text(self.viewModel.commentText)
                            }
                            .opacity(self.shouldShowComment ? 0 : 1)
                            .animation(.default)
                            
//                            HStack {
//                                ZStack {
//                                    GeometryReader { proxy in
//
//                                        HStack {
//                                            TextFieldView(text: self.$commentText)
//                                                .frame(width: 100, height: 40)
//                                            Spacer()
//                                        }
//                                    }
//                                    .offset(x: self.viewModel.checkedButtons[2] ? 0 : proxy.size.width, y: self.viewModel.checkedButtons[2] ? 0 : 25)
//                                    .frame(height: 50)
//                                    .animation(.spring())
//                                }
//                            }
//                            .frame(height: self.commentText.count > 0 ? 50 : 0)
//                            .animation(.default)
                            
                            HStack {
                                Button(action: {
                                    self.viewModel.checkedButtons[0].toggle()
                                    self.viewModel.isWatched.toggle()
                                }) {
                                    CheckButton(imageName: "ticket", textName: "Watched", checked: self.$viewModel.isWatched)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    self.viewModel.checkedButtons[1].toggle()
                                    self.viewModel.isWatchlisted.toggle()
                                }) {
                                    CheckButton(imageName: "popcorn", textName: "Watchlist", checked: self.$viewModel.isWatchlisted)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    self.viewModel.checkedButtons[2].toggle()
                                    self.shouldShowComment.toggle()
                                }) {
                                    CheckButton(imageName: "comment", textName: "Comment", checked: self.$viewModel.hasComment)
                                }
                            }
                            .padding(.top, 20)
                            .padding(.horizontal, 48)
                        }
                        .offset(y: -90)
                    }
                }
            }
            
            Button(action: {
                self.viewModel.closeObservable = true
            }) {
                Image(systemName: "xmark.square")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.white)
                .padding(20)
            }
            .offset(y: 60)
            
            BlurredTextFieldView(commentText: self.$viewModel.commentText, isShowing: self.$shouldShowComment)
                .opacity(self.shouldShowComment ? 1 : 0)
                .offset(x: self.shouldShowComment ? 0 : proxy.size.width)
                .animation(.spring())
        }
        .statusBar(hidden: true)
        .edgesIgnoringSafeArea(.top)
    }
    
    func getOverview() -> String {
        
        if (self.viewModel.result?.overview?.count ?? 0) >= 300 {
            return "\(self.viewModel.result!.overview!.prefix(300))..."
        }
        return self.viewModel.result?.overview ?? ""
    }
}

struct BlurredTextFieldView: View {
    @Binding var commentText: String
    @Binding var isShowing: Bool
    
//    @Binding var viewModel: DetailViewModel
    
    var body: some View {
        ZStack {
            BlurView(style: .regular)
                .edgesIgnoringSafeArea(.bottom)
            
            VStack(spacing: 0) {
                ZStack {
                    HStack(spacing: 0) {
                        
                        Spacer()
                        
                        Text(self.commentText.count == 0 ? "Add new comment" : "Edit or remove comment")
                            .font(Font.system(size: self.commentText.count == 0 ? 22 : 16, weight: .bold))
                        
                        Spacer()
                    }
                    
                    HStack {

                        Button(action: {
                            self.isShowing.toggle()
                        }) {
                            Image(systemName: "xmark.square")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        
                        Spacer()
                    }
                }
                .padding()
                
                HStack(spacing: 0) {
                    Spacer()
                    
                    TextField("", text: self.$commentText)
                        .frame(width: 260)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.second.opacity(0.3))
                        .cornerRadius(8)
                    
                    Spacer()
                }
                .padding()
                
                HStack(spacing: 0) {
                    Spacer()
                    
                    Button(action: {
                        self.isShowing.toggle()
                    }) {
                        Text("Confirm")
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .background(Color.hex("F8F8F8"))
            .cornerRadius(16)
            .padding(.horizontal, 12)
            .shadow(radius: 16)
        }
    }
}

//struct UserInteractionView: View {
//    @Binding var checkedButtons: [Bool]
//
//    var images: [String] = ["ticket", "popcorn", "comment"]
//    var textNames: [String] = ["Watched", "Watchlist", "Comment"]
//
//    var body: some View {
//        HStack {
//            CheckButton(imageName: images[0], textName: textNames[0], checked: $checkedButtons[0])
//                .onTapGesture {
//                    self.checkedButtons[0].toggle()
//            }
//            Spacer()
//            CheckButton(imageName: images[1], textName: textNames[1], checked: $checkedButtons[1])
//                .onTapGesture {
//                    self.checkedButtons[1].toggle()
//            }
//            Spacer()
//            CheckButton(imageName: images[2], textName: textNames[2], checked: $checkedButtons[2])
//                .onTapGesture {
//                    self.checkedButtons[2].toggle()
//            }
//        }
//        .padding(.horizontal, 48)
//    }
//}

struct CheckButton: View {
    var imageName: String
    var textName: String
    @Binding var checked: Bool
    
    var gradient = LinearGradient(gradient: Gradient(colors: [.hex("F99F00"), .hex("DB3069")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    var gradient2 = LinearGradient(gradient: Gradient(colors: [Color.white, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .background(self.checked ? gradient : gradient2)
                    .foregroundColor(.clear)
                    .cornerRadius(30)
                    .animation(.spring())
                
                ZStack {
                    Image("\(self.imageName)_fill")
                        .resizable()
                        .foregroundColor(.hex("ffffff"))
                        .opacity(self.checked ? 1 : 0)
                        .frame(width: 34, height: 34)
                        .animation(.spring())
                    
                    Image("\(self.imageName)_empty")
                        .resizable()
                        .foregroundColor(.hex("979797"))
                        .opacity(self.checked ? 0 : 1)
                        .frame(width: 34, height: 34)
                        .animation(.spring())
                }
            }
            .shadow(color: Color.black.opacity(0.07), radius: 10, y: 8)
            .frame(width: 60, height: 60)
            
            Text(self.textName.uppercased())
                .foregroundColor(.hex("979797"))
                .font(Font.system(size: 12, weight: .medium))
        }
    }
}

struct ReviewsView: View {
    var reviews: [Review]
    @State var moreInfo: [Bool]
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                ScrollView {
                    HStack {
                        Text("Reviews ")
                            .font(Font.system(size: 32, weight: .heavy))

                        Text("(\(self.reviews.count))")
                            .font(Font.system(size: 30, weight: .regular))
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)

                    Rectangle()
                        .fill(Color.hex("a1a1a1"))
                        .frame(height: 1)

                    ForEach(0..<self.reviews.count, id: \.self) { number in
                        
                        VStack {
                            HStack {
                                Text("\(self.reviews[number].author ?? ""):")
                                    .font(Font.system(size: 22, weight: .semibold))

                                Spacer()
                            }
                            
                            if self.moreInfo[number] {
                                Text(self.reviews[number].content ?? "")
                                    .font(Font.system(size: 12, weight: .light))
                                    .multilineTextAlignment(.leading)
                                    .animation(.default)
                                    .padding(.top, 6)
                            } else {
                                Text(self.getInfoFor(id: number))
                                    .font(Font.system(size: 12, weight: .light))
                                    .multilineTextAlignment(.leading)
                                    .animation(.default)
                                    .padding(.top, 6)
                            }
                            
                            if (self.reviews[number].content?.count ?? 0) >= 200 {
                                Button(action: {
                                    self.moreInfo[number].toggle()
                                }) {
                                    Text(self.moreInfo[number] ? "HIDE" : "SHOW MORE")
                                        .font(Font.system(size: 10, weight: .medium))
                                }
                                .padding(.top, 8)
                            }
                            
                            Rectangle()
                                .fill(Color.hex("e9e9e9"))
                                .frame(height: 0.65)
                        }
                        .padding(.horizontal, 24)
                    }
                }
            }
        }
        .background(Color.hex("F8F8F8"))
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func getInfoFor(id: Int) -> String {
        
        if let content = self.reviews[id].content {
            if content.count >= 200 {
                return "\(content.prefix(200))..."
            }
        }
        return self.reviews[id].content ?? ""
    }
}

struct PortraitView: View {
    var cast: Cast
    var image: Image
    
    var body: some View {
        ZStack {
            VStack {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .cornerRadius(8)
                    .shadow(radius: 4, y: 4)
                    .padding(.bottom, 2)
                
                Spacer()
            }
            
            HStack(spacing: 0) {
                Text(self.cast.name ?? "")
                    .lineLimit(0)
                    .font(Font.system(size: 7, weight: .light))
            }
            .frame(width: 150)
            .rotationEffect(Angle(degrees: -90))
            .offset(x: -39)
            
            VStack {
                Spacer()
                
                Text("as")
                    .font(Font.system(size: 7, weight: .ultraLight))
                
                Text(self.cast.character ?? "")
                    .font(Font.system(size: 7, weight: .light))
            }
        }
        .frame(width: 76)
    }
}

struct ScoreView: View {
    var score: CGFloat = 0
    
    var getFirstNumber: String {
        get {
            return String(Int(score))
        }
    }
    
    var getSecondNumber: String {
        get {
            return ".\(String(Int(score.truncatingRemainder(dividingBy: 1) * 10)))"
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                HStack(spacing: 5) {
                    
                    HStack(alignment: .top) {
                        Text(self.getFirstNumber)
                            .font(Font.system(size: 24))
                        Text(self.getSecondNumber)
                            .font(Font.system(size: 16))
                            .offset(x: -7, y: 2)
                    }
                    
                    ForEach(0..<5, id: \.self) { int in
                        Image(systemName: "star.fill")
                            .imageScale(.medium)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(self.score > CGFloat(2 * int) ? Color.red : Color.gray)
                    }
                    Spacer()
                }
            }
            .frame(width: proxy.size.width)
        }
    }
}

struct HeaderView: View {
    var title: String
    var orgTitle: String?
    var image: Image
    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack {
                
                self.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width ,height: proxy.size.height)
                
                HStack(alignment: .bottom) {
                    Rectangle()
                        .frame(width: 160, height: proxy.size.height)
                        .foregroundColor(.clear)
                    
                    VStack {
                        HStack {
                            Text(self.title)
                                .font(Font.system(size: 24, weight: .heavy))
                                .lineLimit(3)
                                .shadow(color: .black, radius: 2, y: 4)
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        
                        if self.orgTitle != nil {
                            
                            HStack {
                                
                                Text(self.orgTitle?.uppercased() ?? "")
                                    .font(Font.system(size: 10, weight: .bold))
                                    .lineLimit(2)
                                    .shadow(color: .black, radius: 2, y: 4)
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                        }
                    }
                    
                    Spacer()
                }
                    
                .offset(y: -5)
            }
        }
    }
}

//struct

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: DetailViewModel())
    }
}
