//
//  NetworkManagerTests.swift
//  Top100AlbumsTests
//
//  Created by Estelle Paus on 6/21/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import XCTest
@testable import Top100Albums

class NetworkManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkManagerHasURL() throws {
        let nm = NetworkManager()
        XCTAssertNotNil(nm.theURL)
    }
    
    func testNetworkManagerUsesGetMethod()  throws {
        let nm = NetworkManager()
        let method = nm.method
        XCTAssertEqual(method, .get)
    }
    
    func testNetworkManagerTimeoutIs30() throws {
        let nm = NetworkManager()
        let timeout = nm.timeoutInterval
        XCTAssertEqual(timeout, 30)
    }
    
    func testParseJsonCreatesAlbumModelArray() throws {
        
        if let path = Bundle.main.path(forResource: "response", ofType: "json") {
            do {
                if let data = NSData(contentsOfFile: path) {
                    let nm = NetworkManager()
                    if let results = nm.parseResponse(data: data as Data) {
                        let array = results as [AlbumModel]
                        XCTAssertEqual(array.count, 2)
                    }
                }
            }
        }
    }
    
    func testParseJsonSuccessfulDespiteMissingField() throws {
           
           if let path = Bundle.main.path(forResource: "responseWithMissingField", ofType: "json") {
               do {
                   if let data = NSData(contentsOfFile: path) {
                       let nm = NetworkManager()
                       if let results = nm.parseResponse(data: data as Data) {
                           let array = results as [AlbumModel]
                           XCTAssertEqual(array.count, 2)
                           let model = array[0]
                           let emptyField = model.artworkUrl100
                           XCTAssertEqual(emptyField, "")
                       }
                   }
               }
           }
       }
}
