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
    let theURL = "https://rss.itunes.apple.com/api/v1/us/itunes-music/top-albums/all/100/explicit.json"
    var timeoutInterval = 30.0
    var method: Method { return .get }
    private var task: URLSessionDataTask?
    
    func makeRequest(completion:  @escaping (_ list: [AlbumModel])->Void) {
        var models = [AlbumModel]()
        guard let url = URL(string: theURL) else { return }
        var request = URLRequest(url: url)
        var headers = [String: String]()
        headers["Accept"] = "application/json"
        request.allHTTPHeaderFields = headers
      
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if let jsonData = data {
                if error != nil {
                    os_log("URLSession error %@",error.debugDescription)
                 return
             }
             
             models = self.parseResponse(data: jsonData) ?? models
             completion(models)
            }
        }).resume()
    }

    func parseResponse(data: Data) -> [AlbumModel]? {

        do {
            let albumResponse = try AlbumResponse.decode(data: data)
            return albumResponse.feed.results
            
        } catch {
            print("JSONDecoder error \(error)")
        }
        
        return nil
    }
}
