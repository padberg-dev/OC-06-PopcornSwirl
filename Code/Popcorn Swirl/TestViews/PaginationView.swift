//
//  PaginationView.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 23.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI

struct PaginationView: View {
    
    @ObservedObject var viewModel: DataGroup
    
    let numberOfEdgePages: Int = 2
    let numberOfNearPages: Int = 2
    
    func pagesArray() -> [Int] {
        if viewModel.allPages > 0 {
            var array: [Int] = []
            
            for i in 1 ... numberOfEdgePages {
                array.append(i)
            }
            
            let minActive = viewModel.pageNumber - numberOfNearPages
            let maxActive = viewModel.pageNumber + numberOfNearPages
            
            for i in minActive ... maxActive {
                array.append(i)
            }
            
            for i in (viewModel.allPages + 1 - numberOfEdgePages) ... viewModel.allPages {
                array.append(i)
            }
            array.sort()
            array = array.filter { $0 >= 1 && $0 <= viewModel.allPages }
            
            var newArray: [Int] = []
            
            var workingInt = 0
            for i in 0 ..< array.count {
                let int = array[i]
                if int != workingInt {
                    if abs(int - workingInt) > 1 {
                        if abs(int - workingInt) == 2 {
                            newArray.append(workingInt + 1)
                        } else {
                            newArray.append(0)
                        }
                    }
                    newArray.append(int)
                    workingInt = int
                }
            }
            
            return newArray
        }
        return []
    }
    
    var body: some View {
        VStack {
            
            HStack(spacing: -10) {
                
                PaginationRectangle(type: .left)
                    .onTapGesture {
                        self.viewModel.pageNumber -= 1
                }
                .padding(.trailing, 26)
                .padding(.leading, 10)
                .padding(.vertical, 8)
                .background(Color.second.opacity(0.6))
                .cornerRadius(8)
                .opacity(self.viewModel.pageNumber > 1 ? 1 : 0.4)
                .offset(x: self.viewModel.pageNumber > 1 ? 0 : 36)
                .animation(.default)
                
                HStack {
                    ForEach(pagesArray(), id: \.self) { number in
                        
                        ZStack {
                            if number != 0 {
                                
                                PaginationRectangle(type: .number, value: number, isActive: number == self.viewModel.pageNumber)
                                    .onTapGesture {
                                        if self.viewModel.pageNumber != number {
                                            self.viewModel.pageNumber = number
                                        }
                                }
                            } else {
                                PaginationRectangle(type: .dots)
                            }
                        }
                    }
                }
                .zIndex(2)
                .padding(.horizontal, 14)
                .padding(.vertical, 14)
                .background(Color.second)
                .cornerRadius(12)
                .animation(.default)
                
                PaginationRectangle(type: .right)
                    .onTapGesture {
                        self.viewModel.pageNumber += 1
                }
                .padding(.trailing, 10)
                .padding(.leading, 26)
                .padding(.vertical, 8)
                .background(Color.second.opacity(0.6))
                .cornerRadius(8)
                .opacity(self.viewModel.pageNumber < self.viewModel.allPages ? 1 : 0)
                .offset(x: self.viewModel.pageNumber < self.viewModel.allPages ? 0 : -36)
                .animation(.default)
            }
        }
        .opacity(viewModel.getCount() != 0 ? 1 : 0.1)
    }
}

enum PaginationType {
    case number, left, right, dots
}

struct PaginationRectangle: View {
    var type: PaginationType
    var value: Int?
    var isActive: Bool = false
    
    func getImage() -> Image {
        var name = ""
        switch type {
        case .left:
            name = "hand.point.left"
        case .right:
            name = "hand.point.right"
        default:
            name = "ellipsis"
        }
        return Image(systemName: name)
    }
    
    func getText() -> Image {
        
        return Image(systemName: "\(value!).square\(isActive ? ".fill" : "")")
    }
    
    var body: some View {
        ZStack {
            if self.type == .number {
                getText()
                    .imageScale(.large)
            } else {
                getImage()
            }
        }
    }
}

struct PaginationView_Previews: PreviewProvider {
    static var previews: some View {
        PaginationView(viewModel: DataGroup(type: .latest))
    }
}
