//
//  ViewModel.swift
//  quoteAPIDemo
//
//  Created by Andy Huang on 3/1/24.
//

import SwiftUI

struct Quote: Codable {
    let id: String
    let content: String
    let author: String
    let authorSlug: String
    let length: Int
    let tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content, author, tags, authorSlug, length
    }
}

typealias QuotesArray = [Quote]

@Observable class ViewModel {
    var fetchedQuote: Quote?
    
    // Fetches a random quote
    func fetchQuote() {
        let urlString: String = "https://api.quotable.io/quotes/random"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("API call error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Bad response code")
                return
            }
            
            // Decode payload
            do {
                guard let jsonData = data else {
                    print("Invalid data")
                    return
                }
                
                let decoder = JSONDecoder()
                let result = try decoder.decode(QuotesArray.self, from: jsonData)
                
                print(result)
                DispatchQueue.main.async {
                    self.fetchedQuote = result[0]
                }
            } catch {
                print("Error decoding response data")
            }
        }
        
        // Execute task
        task.resume()
    }
}
