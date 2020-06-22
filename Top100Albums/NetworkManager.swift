//
//  NetworkManager.swift
//  Top100Bare
//
//  Created by Estelle Paus on 6/17/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import Foundation
import UIKit
import os.log

enum RequestError: Error {
    case invalidURL, noHTTPResponse, http(status: Int)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .noHTTPResponse:
            return "Not a HTTP response."
        case .http(let status):
            return "HTTP error: \(status)."
        }
    }
}

enum Method: String {
    case get, post, put, delete
}

class NetworkManager {
    var running: Bool = false
    var models:  [AlbumModel] = [] {
        didSet {
            NotificationCenter.default.post(name: .ModelListUpdatedNotification, object: models )
        }
    }

    let theURL = "https://rss.itunes.apple.com/api/v1/us/itunes-music/top-albums/all/100/explicit.json"
    var timeoutInterval = 30.0
    var method: Method { return .get }
    private var task: URLSessionDataTask?
    
    func makeRequest(completion: ()->Void) {
        
        guard let url = URL(string: theURL) else { return }
        var request = URLRequest(url: url)
        var headers = [String: String]()
        headers["Accept"] = "application/json"
        request.allHTTPHeaderFields = headers
        running = true
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if let jsonData = data {
                if error != nil {
                    os_log("URLSession error %@",error.debugDescription)
                 return
             }
             
             self.models = self.parseResponse(data: jsonData) ?? self.models
            }
        }).resume()
        completion()
    }

    func parseResponse(data: Data) -> [AlbumModel]? {
        var jsonResponse:Any
        var albumArray = [AlbumModel]()
        do {
            jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
            let response = jsonResponse as? [String: Any]
            
            let feed = response?["feed"] as? [String : Any]
            guard let results = feed?["results"] as? [[String : Any]] else { return albumArray }
            
            for element in results {
                let artistName:String = element["artistName"] as? String ?? ""
                let artistId = element["artistId"] as? String ?? ""
                let rDate = element["releaseDate"] as? String ?? ""
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-mm-dd"
                let releaseDate = dateFormatter.date(from: rDate)
                let name = element["name"] as? String ?? ""
                let artworkUrl100 = element["artworkUrl100"] as? String ?? ""
                let copyright = element["copyright"] as? String ?? ""
                let url = element["url"] as? String ?? ""
                let genres = element["genres"]  as? [[String : Any]] ?? []
                var genreArray = [String]()
                for genre in genres {
                    let genreName:String = genre["name"]  as? String ?? ""
                    if genreName != "Music" {
                        genreArray.append(genreName)
                    }
                }
                let album = AlbumModel.init(artistName: artistName , id: artistId, releaseDate: releaseDate, name: name, url: url, genre: nil, genreStringArray: genreArray, copyright: copyright, artworkUrl100: artworkUrl100)
                albumArray.append(album)
            }
        } catch {
            os_log("JSONSerialization error %@",error.localizedDescription)
        }
        return albumArray
    }
}
