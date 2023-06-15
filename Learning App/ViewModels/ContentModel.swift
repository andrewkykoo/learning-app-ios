//
//  ContentModel.swift
//  Learning App
//
//  Created by Andrew Koo on 6/8/23.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    @Published var codeText = NSAttributedString()
    
    
    var styleData: Data?
    
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
    init() {
        getLocalData()
    }
    
    // MARK: - Data methods
    func getLocalData() {
        
        // get url to the local json data
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        // read the file into a data object
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            let jsonDecoder = JSONDecoder()
            
            do {
                let moduleData = try jsonDecoder.decode([Module].self, from: jsonData)
                self.modules = moduleData
            } catch {
                print("json decoding error", error)
            }
        } catch {
            print("couldn't parse data", error)
        }
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        // parse style data
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        } catch {
            print("couldn't parse style data")
        }
    }
    
    // MARK: - Module navigation methods
    func beginModule(_ moduleId: Int) {
        for index in 0..<modules.count {
            if modules[index].id == moduleId {
                currentModuleIndex = index
                break
            }
        }
        currentModule = modules[currentModuleIndex]
    }

    func beginLesson(_ lessonIndex: Int) {
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        } else {
            currentLessonIndex = 0
        }
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func hasNextLesson() -> Bool {
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    func nextLesson() {
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        } else {
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func beginTest(_ moduleId: Int) {
        beginModule(moduleId)
        currentQuestionIndex = 0
        
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    // MARK: - Code Styling
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        
        // add styling data
        if styleData != nil {
            data.append(self.styleData!)
        }
        
        // add html data
        data.append(Data(htmlString.utf8))
        
        // convert to attributed string
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                
                resultString = attributedString
        } catch {
            print("couldn't turn html into attributed string")
        }
        
        return resultString
    }
}
