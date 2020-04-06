//
//  AlbumController.swift
//  Albums
//
//  Created by Lambda_School_Loaner_259 on 4/6/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import Foundation

class AlbumController {
    
    // MARK: - Properties
    
    
    // MARK: - Coding
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: urlPath)
        
        let decoder = JSONDecoder()
        let weezer = try! decoder.decode(Album.self, from: data)
        
        print("\(weezer)")
    }
    
    func testEncodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: urlPath)
        
        let decoder = JSONDecoder()
        let weezer = try! decoder.decode(Album.self, from: data)
        
        print("\(weezer)")
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let weezerData = try! encoder.encode(weezer)
        
        let dataAsString = String(data: weezerData, encoding: .utf8)!
        print(dataAsString)
    }
}
