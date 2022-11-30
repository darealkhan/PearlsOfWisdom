//
//  QuotesService.swift
//  PearlsOfWisdom
//
//  Created by Huseyn Bayramov on 30.11.22.
//

import Foundation

final class QuotesService {
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
  
  func getRandomQuote() -> QuotesViewModel.Quote? {
      guard let url = Bundle.main.url(forResource: "AllQuotes", withExtension: "json") else { return nil }
      
      do {
          let data = try Data(contentsOf: url)
          let decoder = JSONDecoder()
          let jsonData = try decoder.decode(QuotesViewModel.QuoteModel.self, from: data)
          let quote = jsonData.quotes.randomElement()
          return quote
      } catch let err {
          print(err.localizedDescription)
      }
    
    return nil
  }
}
