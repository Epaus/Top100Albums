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
    var genre: [Genre]
    var copyright: String?
    var artworkUrl100: String?
}
