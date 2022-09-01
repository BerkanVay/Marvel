//
//  MarvelRESTClient.swift
//  Marvel
//
//  Created by Mustafa Berkan Vay on 01.09.2022.
//

import Foundation
import CryptoKit

class MarvelRESTClient {
  
  enum NetworkingError: Error {
    case invalidURL
    case noData
    case generic(error: Error)
    case decoding(error: Error)
  }
  
  private static let jsonDecoder = JSONDecoder()
  
  static func getCharacterResult(offset: Int, APIKey: String, privateAPIKey: String, ts: String, completionHandler: @escaping (Result<CharactersResult, NetworkingError>) -> Void) {
    let requestHash = MarvelRESTClient.MD5(string: "\(ts)\(privateAPIKey)\(APIKey)")
    let requestURLString = "https://gateway.marvel.com/v1/public/characters?ts=\(ts)&apikey=\(APIKey)&hash=\(requestHash)&limit=20&offset=\(offset)"
    MarvelRESTClient.doRequest(withURLString: requestURLString, completionHandler: completionHandler)
  }
  
  private static func doRequest<T: Decodable>(
    withURLString urlString: String,
    completionHandler: @escaping (Result<T, NetworkingError>) -> Void
  ) {
    guard let url = URL(string: urlString) else {
      completionHandler(.failure(.invalidURL))
      return
    }
    
    let task = URLSession.shared.dataTask(
      with: url
    ) { data, response, error in
      if let error = error {
        completionHandler(.failure(.generic(error: error)))
        return
      }
      
      guard let data = data else {
        completionHandler(.failure(.noData))
        return
      }
      
      do {
        let response = try jsonDecoder.decode(T.self, from: data)
        
        completionHandler(.success(response))
      } catch {
        completionHandler(.failure(.decoding(error: error)))
      }
    }
    
    task.resume()
  }
  
  private static func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
    
    return digest.map {
      String(format: "%02hhx", $0)
    }.joined()
  }
  
}
