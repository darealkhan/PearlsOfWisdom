//
//  HomeViewModel.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Seferli on 15.10.22.
//

import Foundation

class HomeViewModel {
    var onFetch: (([HomeCellModel]) -> Void)?
    
    func fetchData(completion: @escaping ([HomeCellModel]) -> Void) {
        var homeTableViewData = [HomeCellModel]()
        
        guard let url = Bundle.main.url(forResource: "AppData", withExtension: "json") else {
            return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(AppData.self, from: data)
            for childItemWithHtml in jsonData.childItemsWithHTML {
                if let html = childItemWithHtml.localFileName {
                    for childItem in jsonData.childItems {
                        if childItem.titleText.contains(childItemWithHtml.itemNickname) {
                            let htmlSplit = html.split(separator: ".")
                            let htmlName = String(htmlSplit[0])
                            homeTableViewData.append(HomeCellModel(title: childItem.titleText, arabicTitle: childItem.descriptionText, fileName: htmlName))
                        }
                    }
                }
            }
            homeTableViewData.sort(by: {$0.title < $1.title})
            completion(homeTableViewData)
        } catch let err {
            print(err.localizedDescription)
        }
    }
}
