//
//  AlbumModelTests.swift
//  Top100AlbumsTests
//
//  Created by Estelle Paus on 6/21/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import XCTest
@testable import Top100Albums

class AlbumModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInstantiateAlbumModel() throws {
        
        let model = AlbumModel.init(artistName: "Jimmy Buffet", id: "61232", releaseDate: Date(), name: "Madonna's Greatest Hits", url: "http://", genre: nil, genreStringArray:["Pop", "Pop/Rock", "Adult Contemporary", "Soft Rock", "Rock", "Singer/Songwriter", "Southern Rock"], copyright: "This Compilation ℗ 1985 Geffen Records", artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/b4/6e/87/b46e870f-c438-464a-c1ac-357b47da56bc/00076732563328.rgb.jpg/200x200bb.png")
        XCTAssertNotNil(model)
    }
}
