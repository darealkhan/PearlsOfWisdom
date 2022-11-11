//
//  QuotesViewModel.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Səfərli on 10.11.22.
//

import Foundation

class QuotesViewModel {
    func getQuotes(completion: @escaping ([QuotesViewModel.Quote]) -> Void) {
        guard let url = Bundle.main.url(forResource: "AllQuotes", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(QuotesViewModel.QuoteModel.self, from: data)
            completion(jsonData.quotes.shuffled())
        } catch let err {
            print(err.localizedDescription)
        }
    }
}

extension QuotesViewModel {
    struct QuoteModel: Codable {
        let quotes: [Quote]
    }

    struct Quote: Codable {
        let quote, author: String
    }
}
