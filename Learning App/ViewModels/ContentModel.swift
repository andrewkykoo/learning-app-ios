//
//  ContentModel.swift
//  Learning App
//
//  Created by Andrew Koo on 6/8/23.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
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
}
