//
//  QuotesViewModel.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Səfərli on 10.11.22.
//

import Foundation

class QuotesViewModel {
    
}

extension QuotesViewModel {
    struct QuoteModel: Codable {
        let quotes: [Quote]
    }

    struct Quote: Codable {
        let quote, author: String
    }
}
