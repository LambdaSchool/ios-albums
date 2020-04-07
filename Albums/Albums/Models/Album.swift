//
//  Album.swift
//  Albums
//
//  Created by Lambda_School_Loaner_259 on 4/6/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
    }
    
//    enum CoverArtKeys: String, CodingKey {
//        case url
//    }
    
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
    init(artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Song]) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        genres = try container.decode([String].self, forKey: .genres)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        songs = try container.decode([Song].self, forKey: .songs)
        
        var coverartContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        let coverArtDict = try coverartContainer.decode([String : String].self)
        var coverArtURLs: [URL] = []
        
        for coverArt in coverArtDict {
            let coverArtURLString = coverArt.value
            
            if let coverArtURL = URL(string: coverArtURLString) {
                coverArtURLs.append(coverArtURL)
            }
        }
        
        self.coverArt = coverArtURLs
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(songs, forKey: .songs)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        for coverArtURL in coverArt {
            let coverArtString = coverArtURL.absoluteString
            let coverArtDict = ["url" : coverArtString]
            try coverArtContainer.encode(coverArtDict)
        }
    }
}

struct Song: Codable {
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
    }
    
    enum DurationKey: String, CodingKey {
        case duration
    }
    
    enum NameKey: String, CodingKey {
        case title
    }
    
    let duration: String
    let id: String
    let name: String
    
    init(duration: String, id: String, name: String) {
        self.duration = duration
        self.id = id
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: DurationKey.self, forKey: .duration)
        self.duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameKey.self, forKey: .name)
        self.name = try nameContainer.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        
        try container.encode(id, forKey: .id)
        
        //var nameContainer = container.nestedUnkeyedContainer(forKey: .name)
        let nameDict = ["title" : name]
        try container.encode(nameDict, forKey: .name)
        
        //var durationContainer = container.nestedUnkeyedContainer(forKey: .duration)
        let durationDict = ["duration" : duration]
        try container.encode(durationDict, forKey: .duration)
    }
}
