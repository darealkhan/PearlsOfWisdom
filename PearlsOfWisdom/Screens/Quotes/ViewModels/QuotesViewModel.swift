//
//  QuotesViewModel.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Səfərli on 10.11.22.
//

import Foundation

class QuotesViewModel {
  private let service = QuotesService()
  
  func getQuotes(completion: @escaping ([QuotesViewModel.Quote]) -> Void) {
    return service.getQuotes(completion: completion)
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
