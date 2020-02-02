//
//  TextFieldPlus.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 29.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI
import UIKit

struct TextFieldPlus: View {
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            TextFieldView(text: self.$text)
        }
    }
}

struct TextFieldPlus_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldPlus()
    }
}

struct TextFieldView: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<TextFieldView>) -> UIView {
        let view = UIView(frame: .zero)
        
        context.coordinator.textField = UITextField()
        context.coordinator.textField.borderStyle = .roundedRect
        
        context.coordinator.textField.delegate = context.coordinator
        context.coordinator.textField.addTarget(self, action: #selector(context.coordinator.textChanged(_:)), for: .valueChanged)
        context.coordinator.textField.frame.size = .init(width: UIScreen.main.bounds.width - 96, height: 40)
        
        view.addSubview(context.coordinator.textField)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<TextFieldView>) {
        
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldView
        var textField: UITextField!

        
        @objc func textChanged(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return true
        }
        
        init(_ textFieldView: TextFieldView) {
            self.parent = textFieldView
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
//            textField.frame.origin.y -= 400
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }
}
