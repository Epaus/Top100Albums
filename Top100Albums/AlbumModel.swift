//
//  AlbumModel.swift
//  Top100Bare
//
//  Created by Estelle Paus on 6/17/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

struct Feed: Codable {
    var results: [AlbumModel]
}

struct Genre: Codable {
    var genreId: String?
    var name: String?
    var url: String?
}

struct AlbumModel: Codable {
    var artistName: String?
    var id: String?
    var releaseDate: Date?
    var name: String?
    var url: String?
    var genre: [Genre]?
    var genreStringArray: [String]
    var copyright: String?
    var artworkUrl100: String?
    
    init(artistName: String?, id: String?, releaseDate: Date?, name: String?, url: String?,  genre: [Genre]? = nil, genreStringArray: [String], copyright: String?, artworkUrl100: String?) {
        self.artistName = artistName
        self.id = id
        self.releaseDate = releaseDate
        self.name = name
        self.url = url
        self.genreStringArray = genreStringArray
        self.copyright = copyright
        self.artworkUrl100 = artworkUrl100
    }
}
