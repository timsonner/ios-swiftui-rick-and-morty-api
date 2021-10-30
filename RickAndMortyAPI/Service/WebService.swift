//
//  WebService.swift
//  WebService
//
//  Created by Timothy Sonner on 9/29/21.
//

import SwiftUI

struct WebService: Decodable {
    
    enum WebServiceError: Error {
        case genericFailure
        case failedToDecodeData
        case invalidStatusCode
    }
    
    // New way of making a network request (ios15+):
    func fetchCharacters(url: String) async throws -> APIResponse? {
        // async marks function as asyncronous, throws marks it as able to throw errors
 
        let (data, response) = try await URLSession.shared.data(from: URL(string: url)!)
        // tries to create a URLSession from the URL object
        
        guard let networkRequestResponse = response as? HTTPURLResponse,
              networkRequestResponse.statusCode == 200 else {
                  throw WebServiceError.invalidStatusCode
              }  // checks if a HTTPURLResponse object can be created and if its status code is 200
        
             let decodedData = try JSONDecoder().decode(APIResponse.self, from: data)
        // decode the data from URL session
        return (decodedData.self)
    }
    
    func fetchEpisodes(url: String) async throws -> Episode? {
        // async marks function as asyncronous, throws marks it as able to throw errors
 
        let (data, response) = try await URLSession.shared.data(from: URL(string: url)!)
        // tries to create a URLSession from the URL object
        
        guard let networkRequestResponse = response as? HTTPURLResponse,
              networkRequestResponse.statusCode == 200 else {
                  throw WebServiceError.invalidStatusCode
              }  // checks if a HTTPURLResponse object can be created and if its status code is 200
        
        let decodedData = try JSONDecoder().decode(Episode.self, from: data)
        // decode the data from URL session
        return (decodedData.self)
    }
    
}




























// // New way of making a network request (ios15+):
//func NetworkRequest(page: String, name: String) async throws -> [Character]? {
//    // async marks function as asyncronous, throws marks it as able to throw errors
//    var components: URLComponents
//    // Build a URL from URLComponents, allows for more flexibility than a static URL.
//
//        components = URLComponents()
//        components.scheme = "https"
//        components.host = "rickandmortyapi.com"
//        components.path = "/api/character"
//        components.queryItems = [
//            URLQueryItem(name: "page", value: page),
//            URLQueryItem(name: "name", value: name)
//        ]
//
//    let (data, response) = try await URLSession.shared.data(from: components.url!)
//    // tries to create a URLSession from the URL object
//
//    guard let networkRequestResponse = response as? HTTPURLResponse,
//          networkRequestResponse.statusCode == 200 else {
//              throw WebServiceError.invalidStatusCode
//          }  // checks if a HTTPURLResponse object can be created and if its status code is 200
//
//         let decodedData = try JSONDecoder().decode(Results.self, from: data)
//    // decode the data from URL session
//    return (decodedData.results)
//}
//}














// Old way of making a network requestv(<iOS15):

//    let results: [Character]  // used to store successfully decoded result from fetchCharacters()
//
//    func NetworkRequest(completion: @escaping (Result<[Character], Error>) -> Void) {
//        let urlEndpoint = "https://rickandmortyapi.com/api/character"
//        let session = URLSession
//            .shared
//            .dataTask(with: .init(url: URL(string: urlEndpoint)!)) {data, response, error in
//                 // create a URL session object using the provided URL endpoint returning the requested data, a HTTP response, or a possible error.
//
//                guard (response as? HTTPURLResponse) != nil else {
//                    completion(.failure(WebServiceError.responseWasNil))
//                    return
//                }  // checks if the response is nil
//
//                guard let responseObject = response as? HTTPURLResponse else {
//                    return
//                }  // checks if a valid HTTPURLResponse object can be created from the URL session response
//
//                guard responseObject.statusCode == 200 else {
//                    completion(.failure(WebServiceError.invalidStatusCode))
//                    return
//                }  // checks if response has a HTTP status code of 200
//
//                guard data != nil else {
//                    completion(.failure(WebServiceError.dataWasNil))
//                    return
//                }  // checks if data is nil
//
//                guard let dataToDecode = data,
//                      let decodedData = try? JSONDecoder().decode(WebService.self, from: dataToDecode) else {
//                          completion(.failure(WebServiceError.failedToDecodeData))
//                          return
//                      }  // checks if data returned from session is decodable
//
//                completion(.success(decodedData.results))
//            }  // session data was successfully parsed, return data as Result
//        session.resume()
//    }

// for testing network connectivity:

// let configuration = URLSessionConfiguration.ephemeral
//        let (data, response) = try await URLSession(configuration: configuration).data(from: urlObject)
