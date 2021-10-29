//
//  CharacterServiceResult.swift
//  RickAndMortyAPI
//
//  Created by Timothy Sonner on 9/29/21.
//

import Foundation

struct Origin: Decodable, Equatable {
    let name: String
}


// MARK: - APIResponse
struct APIResponse: Codable {
    let info: Info
    let results: [Result]
}

// MARK: - Info
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Result: Codable, Identifiable, Equatable, Hashable {
    
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Location
struct Location: Codable, Equatable, Hashable {
    let name: String
    let url: String
}

enum Gender: String, Codable, Hashable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

enum Status: String, Codable, Hashable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

