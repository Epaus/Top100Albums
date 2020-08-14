//
//  AlbumModel.swift
//  Top100Bare
//
//  Created by Estelle Paus on 6/17/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

struct AlbumResponse: Codable {
    let feed: Feed
    
    static func decode(data: Data) throws -> AlbumResponse {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return try decoder.decode(AlbumResponse.self, from: data)
    }
}

struct Feed: Codable {
    let results: [AlbumModel]
}

struct Genre: Codable {
    let genreId: String?
    let name: String?
    let url: String?
}

struct AlbumModel: Codable {
    let artistName: String?
    let id: String?
    let releaseDate: Date?
    let name: String?
    let url: String?
    let genres: [Genre]?
    let copyright: String?
    let artworkUrl100: String?
}
