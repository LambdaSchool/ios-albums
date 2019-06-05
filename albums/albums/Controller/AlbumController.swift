//
//  AlbumController.swift
//  albums
//
//  Created by Hector Steven on 6/3/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation


class AlbumController {
	func testDecodingExampleAlbum() {
		if let jsonURL = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") {
			if let data = try? Data(contentsOf: jsonURL) {
				self.parseAlbumJsonData(with: data)
			}
		}
	}
	
	private func parseAlbumJsonData(with data: Data) {
		let decoder = JSONDecoder()
		do {
			let albumsDecoded = try decoder.decode(Album.self, from: data)
			albums.append(albumsDecoded)
			print(albumsDecoded)
		} catch {
			NSLog("Error decoding json: \(error)")
		}
	}
	
	func testEncodingExampleAlbum(album: Album) {
		let plistEncoder = PropertyListEncoder()
		plistEncoder.outputFormat = .xml
		
		do {
			let plistData = try plistEncoder.encode(album)
			print(plistData)
//			let str = String(data: plistData, encoding: .utf8)
			print("testEncodingExampleAlbum->>>>")
			parseAlbumJsonData(with: plistData)
		} catch {
			print("Error encoding :\(error)")
		}
	}

	init() {
		testDecodingExampleAlbum()
		testEncodingExampleAlbum(album: albums[0])
	}
	
	var albums: [Album] = []
}
