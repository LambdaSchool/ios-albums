//
//  AlbumController.swift
//  Albums
//
//  Created by Mark Gerrior on 4/6/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

class AlbumController {
    func testDecodingExampleAlbum() {
        
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        
        let data = try! Data(contentsOf: urlPath)

        let decoder = JSONDecoder()

        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        let weezer = try! decoder.decode(Album.self, from: data)

        print("\(weezer)\n")

    }
}
