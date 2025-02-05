//
//  Music.swift
//  music
//
//  Created by Nitya Addanki on 2/3/25.
//

import Foundation

struct Music: Identifiable, Codable, Hashable {
    var id: Int
    var title: String
    var artist: String
    var album: String
    var genre: String
    var releaseYear: Int
    var duration: String
    var trackNumber: Int
    var coverImage: String
    var description: String
    var isLike: Bool = false
    var ratings: Int = 0
    
    static let `default` = Self(id: 0, title: "Blinding Lights", artist: "The Weeknd", album: "After Hours", genre: "Pop", releaseYear: 2025, duration: "3:20", trackNumber: 1, coverImage: "charleyrivers", description: "A catchy, retro-inspired synthwave track that became a global hit, blending modern pop with 80s nostalgia.The Weeknd", isLike: false, ratings: 1)
}
