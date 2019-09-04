//
//  AlbumController.swift
//  Albums
//
//  Created by Jeffrey Santana on 9/3/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

enum NetworkError: Error {
	case badURL
	case noToken
	case noData
	case notDecoding
	case notEncoding
	case other(Error)
}

enum HTTPMethod: String {
	case get = "GET"
	case put = "PUT"
	case post = "POST"
	case delete = "DELETE"
}

class AlbumController {
	
	private var albums = [Album]()
	var albumsByArtist: [String:[Album]] {
		return Dictionary(grouping: albums, by: {$0.artist})
	}
	
	let baseURL = URL(string: "https://santana-discography.firebaseio.com/")!
	
	func getAlbums(completion: @escaping (Result<Bool, NetworkError>) -> Void) {
		let requestUrl = baseURL//.appendingPathComponent("json")
		
		URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
			if let error = error {
				if let response = response as? HTTPURLResponse, response.statusCode != 200 {
					NSLog("Error: status code is \(response.statusCode) instead of 200.")
				}
				NSLog("Error creating user: \(error)")
				completion(.failure(.other(error)))
				return
			}
			
			guard let data = data else {
				NSLog("No data was returned")
				completion(.failure(.noData))
				return
			}
			
			do {
				self.albums = try JSONDecoder().decode([String:Album].self, from: data).compactMap({$0.value})
				completion(.success(true))
			} catch {
				completion(.failure(.notDecoding))
			}
			}.resume()
	}
	
//	func putAlbum(<#parameters#>) -> <#return type#> {
//		<#function body#>
//	}
	
//	func testDecodingExampleAlbum() {
//		guard let filePath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
//		do {
//			let data = try Data(contentsOf: filePath)
//			let decoder = JSONDecoder()
//			let testAlbum = try decoder.decode(Album.self, from: data)
//			albums.append(testAlbum)
//			print(albums)
//		} catch {
//			NSLog("Error decoding: \(error)")
//		}
//	}
//
//	func testEncodingExampleAlbum() {
//		guard let filePath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
//		do {
//			let data = try Data(contentsOf: filePath)
//			let decodedData = try JSONDecoder().decode(Album.self, from: data)
//			let encodedData = try JSONEncoder().encode(decodedData)
//			let albumString = String(data: encodedData, encoding: .utf8)!
//			print(albumString)
//		} catch {
//			NSLog("Error encoding: \(error)")
//		}
//	}
}

