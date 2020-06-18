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

enum QueryType {
       case body
       case path
   }

class NetworkManager {
    
    var models:  [AlbumModel] = [] {
        didSet {
            print("models - didSet!")
            //NotificationCenter.default.post(name: .ImageModelListUpdatedNotification, object: models )
        }
    }
    static let shared = NetworkManager()
    let theURL = "https://rss.itunes.apple.com/api/v1/us/itunes-music/top-albums/all/10/explicit.json" //"https://rss.itunes.apple.com/api/v1/us/apple-music"
    var endpoint = "/top-albums/all/100/explicit.json"
    var type: QueryType { return .path }
    var timeoutInterval = 30.0
    
    var method: Method { return .get }
    private var task: URLSessionDataTask?
    var searchParameter = String()
    var prevSearchParameter = String()
    
    func performRequest() {
           guard var request = try? prepareURLRequest() else {
               os_log("failed to prepare URLRequest")
               return
           }
           var headers = [String: String]()
            headers["Accept"] = "application/json"
            headers["Content-Type"] = "application/json"
           request.allHTTPHeaderFields = headers
           request.httpMethod = method.rawValue
        request.httpShouldHandleCookies = false
        
           
           let session = URLSession.shared
           task = session.dataTask(with: request, completionHandler: { (data, response, error) in
               if let jsonData = data {
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                
                //self.models = self.parseJSON(jsonData) ?? [AlbumModel]()
                self.models = self.parseOuterResponse(data: jsonData) ?? self.models
                
               }
           })
           task?.resume()
       }
    
    func prepareHeaders() -> [String: String]? {
              var headers = [String: String]()
              headers["Accept"] = "application/json"
             // headers["Content-Type"] = "application/json"
              return headers
          }
    
    func prepareURLRequest() throws -> URLRequest {
           
           var parameters = ["per_page":30, "page":1 ] as [String : Any]
        
           guard let url = prepareURLComponents()?.url else {
               throw RequestError.invalidURL
           }
           
           switch type {
           case .body:
               var mutableRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeoutInterval)
                   mutableRequest.httpBody = try JSONSerialization.data(withJSONObject: [], options: [])
                  
               
               return mutableRequest

           case .path:
               var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
               //components.query = queryParameters(parameters)
               let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeoutInterval)
               return urlRequest
           }
       }
    
    private func queryParameters(_ parameters: [String: Any]?, urlEncoded: Bool = false) -> String {
        var allowedCharacterSet = CharacterSet.alphanumerics
        allowedCharacterSet.insert(charactersIn: ".-_")

        var query = ""
        parameters?.forEach { key, value in
            let encodedValue: String
          
            if let value = value as? String {
                encodedValue = urlEncoded ? value.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? "" : value
            } else {
                encodedValue = "\(value)"
            }
            query = "\(query)\(key)=\(encodedValue)&"
        }
        
        return query
    }
    
    func prepareURLComponents() -> URLComponents? {
           guard let apiURL = URL(string: self.theURL) else {
                  return nil
              }
              var urlComponents = URLComponents(url: apiURL, resolvingAgainstBaseURL: true)
              urlComponents?.path = endpoint
              return urlComponents
          }
    
    func parseJSON(_ data: Data) -> [AlbumModel]? {
        var albumArray = [AlbumModel]()
        let decoder = JSONDecoder()
        do {
            let results = try decoder.decode(Feed.self, from: data)
//            for album in results {
//                let artistName = album.artistName
//            }
           // let decodedData = try decoder.decode([AlbumModel].self, from: data)
//            for data in decodedData {
//
//                let id = data.id
//                let artistName = data.artistName
//            }
            
            return albumArray
            
        } catch {
            os_log("parseJSON error %@",error.localizedDescription)
            return nil
        }
    }
    
    func parseOuterResponse(data: Data) -> [AlbumModel]? {
           var jsonResponse:Any
           do {
               jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
               let jResponse = jsonResponse as? [String: Any]
               let imageArray = [AlbumModel]()
               let results = jResponse?["results"]
               
               do {
                   let data = try JSONSerialization.data(withJSONObject: results as Any, options: [])
                   return self.parseJSON(data)
                   
               } catch  {
                    os_log("JSONSerialization error %@",error.localizedDescription)
               }
               return imageArray
               
           } catch {
               os_log("JSONSerialization error %@",error.localizedDescription)
           }
           
           return nil
       }
}
