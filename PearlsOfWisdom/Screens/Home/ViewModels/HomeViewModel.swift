//
//  HomeViewModel.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Seferli on 15.10.22.
//

import Foundation

class HomeViewModel {
    func getQuotes(completion: @escaping ([HomeCellModel]) -> Void) {
        var homeTableViewData = [HomeCellModel]()
        
        guard let url = Bundle.main.url(forResource: "HomeViewModelQuotes", withExtension: "json") else {
            return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(HomeViewModel.Quotes.self, from: data)
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

extension HomeViewModel {
    // MARK: - AppData
    struct Quotes: Codable {
        let childItems: [ChildItem]
        let childItemsWithHTML: [ChildItemsWithHTML]

        enum CodingKeys: String, CodingKey {
            case childItems
            case childItemsWithHTML = "childItemsWithHtml"
        }
    }

    // MARK: - ChildItem
    struct ChildItem: Codable {
        let itemID: String
        let itemType: ChildItemItemType
        let loadScreenWithItemID, titleText, descriptionText: String
        let rowAccessoryType: RowAccessoryType

        enum CodingKeys: String, CodingKey {
            case itemID = "itemId"
            case itemType
            case loadScreenWithItemID = "loadScreenWithItemId"
            case titleText, descriptionText, rowAccessoryType
        }
    }

    enum ChildItemItemType: String, Codable {
        case btMenuItem = "BT_menuItem"
    }

    enum RowAccessoryType: String, Codable {
        case none = "none"
    }

    // MARK: - ChildItemsWithHTML
    struct ChildItemsWithHTML: Codable {
        let itemID: String
        let itemType: ChildItemsWithHTMLItemType
        let itemNickname: String
        let navBarTitleText: String?
        let navBarStyle: NavBarStyle?
        let localFileName, startTransitionAfterSeconds, transitionDurationSeconds, transitionType: String?
        let backgroundColor, backgroundImageNameSmallDevice, backgroundImageNameLargeDevice, backgroundImageScale: String?
        let forceRefresh: String?

        enum CodingKeys: String, CodingKey {
            case itemID = "itemId"
            case itemType, itemNickname, navBarTitleText, navBarStyle, localFileName, startTransitionAfterSeconds, transitionDurationSeconds, transitionType, backgroundColor, backgroundImageNameSmallDevice, backgroundImageNameLargeDevice, backgroundImageScale, forceRefresh
        }
    }

    enum ChildItemsWithHTMLItemType: String, Codable {
        case btScreenHTMLDoc = "BT_screen_htmlDoc"
        case btScreenSplash = "BT_screen_splash"
    }

    enum NavBarStyle: String, Codable {
        case hidden = "hidden"
    }
}
