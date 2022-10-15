//
//  CategoriesModel.swift
//  pearlsofwisdom
//
//  Created by Ayxan Seferli on 05.10.22.
//

import Foundation

// MARK: - AppData
struct AppData: Codable {
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
