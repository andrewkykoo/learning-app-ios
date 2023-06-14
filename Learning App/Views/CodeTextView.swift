//
//  CodeTextView.swift
//  Learning App
//
//  Created by Andrew Koo on 6/13/23.
//

import SwiftUI
import UIKit

struct CodeTextView: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        textView.attributedText = model.lessonDescription
        
        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
}

struct CodeTextView_Previews: PreviewProvider {
    static var previews: some View {
        CodeTextView()
    }
}