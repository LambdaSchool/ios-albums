//
//  AlbumController.swift
//  Albums
//
//  Created by Hunter Oppel on 4/9/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation

final class AlbumController {
    
    // MARK: Properties
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }
    enum NetworkError: Error {
        case failedFetch, badURL, badData
        case failedPut
        case failedPost
    }
    
    let decoder = JSONDecoder()
    let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }()
    
    var albums = [Album]()
    let baseURL: URL = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
    
    // MARK: - API Interaction Functions
    
    func getAlbumList(completion: @escaping (Result<Bool, NetworkError>) -> Void ) {
        let request = apiRequest(for: baseURL, responseType: .get)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Fetch albums failed with error: \(error.localizedDescription)")
                completion(.failure(.failedFetch))
            }
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200
                else {
                    print("Fetch returned with bad response")
                    return completion(.failure(.failedFetch))
            }
            guard let data = data else {
                print("Data was void")
                return completion(.failure(.badData))
            }
            
            do {
                let albums = try self.decoder.decode([Album].self, from: data)
                self.albums = albums
                completion(.success(true))
            } catch {
                print("Error decoding albums: \(error.localizedDescription)")
                completion(.failure(.failedFetch))
            }
        }
        .resume()
    }
    
    func changeAlbum(album: Album, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        let albumURL = baseURL.appendingPathComponent(album.id)
        var request = apiRequest(for: albumURL, responseType: .put)
        
        do {
            let data = try encoder.encode(album)
            request.httpBody = data
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Failed to change album with error: \(error.localizedDescription)")
                    completion(.failure(.failedPut))
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("Change returned with bad response")
                    return completion(.failure(.failedPut))
                }
                guard let data = data else {
                    print("Data was void")
                    return completion(.failure(.badData))
                }
                
                do {
                    // I couldnt think of how to remove the old album from the array and then add the updated one back
                    let albums = try self.decoder.decode([Album].self, from: data)
                    self.albums = albums
                    completion(.success(true))
                } catch {
                    print("Error decoding albums: \(error.localizedDescription)")
                    completion(.failure(.failedFetch))
                }
            }
            .resume()
            
            completion(.success(true))
        } catch {
            print("Error encoding album: \(error.localizedDescription)")
            completion(.failure(.failedPut))
        }
    }
    
    func postAlbum(album: Album, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        var request = apiRequest(for: baseURL, responseType: .post)
        
        do {
            let data = try encoder.encode(album)
            request.httpBody = data
            
            URLSession.shared.dataTask(with: request) { _, response, error in
                if let error = error {
                    print("Failed to add album with error: \(error.localizedDescription)")
                    completion(.failure(.failedPost))
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("Post returned with bad response")
                    return completion(.failure(.failedPost))
                }
            }
            .resume()
            
            self.albums.append(album)
            completion(.success(true))
        } catch {
            print("Error encoding album: \(error.localizedDescription)")
            completion(.failure(.failedPost))
        }
    }
    
    func createSong(title: String, duration: String) -> Song {
        let title = Name(title: title)
        let duration = Duration(duration: duration)
        let song = Song(name: title, duration: duration)
        return song
    }
    
    // MARK: - Helper Methods
    
    private func apiRequest(for url: URL, responseType: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = responseType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    // MARK: - Codable Tests
    
    func testDecodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {return}
        
        do {
            let data = try Data(contentsOf: urlPath)
            let result = try decoder.decode(Album.self, from: data)
            print(result)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func testEncodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {return}
        
        do {
            let data = try Data(contentsOf: urlPath)
            let result = try decoder.decode(Album.self, from: data)
//            print(result)
            
            let encoded = try encoder.encode(result)
            print(String(data: encoded, encoding: .utf8)!)
        } catch {
            print(error.localizedDescription)
        }
    }
}
