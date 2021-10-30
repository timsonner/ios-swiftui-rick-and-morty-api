//
//  CharacterServiceResult.swift
//  RickAndMortyAPI
//
//  Created by Timothy Sonner on 9/29/21.
//

import Foundation

struct APIResponse: Decodable {
    let info: Info
    let results: [Result]
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Result: Decodable, Identifiable, Equatable, Hashable {
    
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Location: Decodable, Equatable, Hashable {
    let name: String
    let url: String
}

struct Origin: Decodable, Equatable {
    let name: String
}

struct Episode: Decodable, Hashable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}

enum Gender: String, Decodable, Hashable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

enum Status: String, Decodable, Hashable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}


