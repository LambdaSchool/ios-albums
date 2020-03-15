//
//  Album.swift
//  ios-albums
//
//  Created by Joseph Rogers on 3/9/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import Foundation

struct Album: Codable {
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
    
    init(artist: String, coverArt: [String], genres: [String], id: String, name: String, songs: [Song]) {
        let coverArtURLs = coverArt.compactMap { URL(string: $0) }
        
        self.artist = artist
        self.coverArt = coverArtURLs
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    init(from decoder: Decoder) throws {
        //created the container
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        //assigned the artist initilized to any album in the containter with the key of .artist
        self.artist = try container.decode(String.self, forKey: .artist)
        
        //created an array to hold all the cover art URLs
        var coverArts: [URL] = []
        //the json is nested, so we dig deeper into the container.
        var coverArtsContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        //if the cover art container isnt at its end index, keep on decoding urls and appending them to coverArts until finished.
        while !coverArtsContainer.isAtEnd {
            let urlContainer = try coverArtsContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let url = try urlContainer.decode(URL.self, forKey: .url)
            coverArts.append(url)
        }
        self.coverArt = coverArts
        
        self.genres = try container.decode([String].self, forKey: .genres)
        
        self.id = try container.decode(String.self, forKey: .id)
        
        self.name = try container.decode(String.self, forKey: .name)
        
        self.songs = try container.decode([Song].self, forKey: .songs)
    }
    //encoding is essentially the same as decoding. just creating containers to PUT things into. 
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        
        var coverArtsContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for coverArt in coverArt {
            var urlContainer = coverArtsContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            try urlContainer.encode(coverArt, forKey: .url)
        }
        
        try container.encode(genres, forKey: .genres)
        
        try container.encode(id, forKey: .id)
        
        try container.encode(name, forKey: .name)
        
        try container.encode(songs, forKey: .songs)
    }
}
