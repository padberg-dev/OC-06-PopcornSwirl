//
//  ImageUrl.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 04.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI
import Combine

struct ImageUrl: View {
    var body: some View {
        ZStack {
            URLImage(url: URL(string: "https://image.tmdb.org/t/p/w500/8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg")!)
        }
    }
}

struct URLImage: View {
    var placeholder: Image
    
    @ObservedObject private var imageLoader: ImageLoader
    
    init(url: URL, placeholderImage: Image = Image(systemName: "photo")) {
        self.placeholder = placeholderImage
        self.imageLoader = ImageLoader(url: url)
    }
    
    var body: Image {
        
        imageLoader.getImage()
    }
}

class ImageLoader: ObservableObject {
    
    var url: URL!
    @Published var image: Image?
    
    func load() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.image = Image(uiImage: UIImage(data: data) ?? UIImage())
            }
        }.resume()
    }
    
    func getImage() -> Image {
        if let img = image {
            return img
        } else {
            self.load()
            return Image(systemName: "photo")
        }
    }
    
    init(url: URL) {
        self.url = url
    }
}

struct ImageUrl_Previews: PreviewProvider {
    static var previews: some View {
        ImageUrl()
    }
}
