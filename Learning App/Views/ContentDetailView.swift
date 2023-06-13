//
//  ContentDetailView.swift
//  Learning App
//
//  Created by Andrew Koo on 6/12/23.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            if model.hasNextLesson() {
                Button {
                    model.nextLesson()
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .frame(height: 48)
                        
                        Text("Next: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(.white)
                            .bold()
                        
                        
                    }
                }
            }
        }
        .padding()
    }
}

//struct ContentDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentDetailView()
//    }
//}
