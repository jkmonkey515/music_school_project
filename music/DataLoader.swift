//
//  DataLoader.swift
//  music
//
//  Created by Nitya Addanki on 2/3/25.
//

import Foundation

@Observable
class AppData {
    var musicTests: [Music] = load("music.json")
}


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data


    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

//func loadMusic() -> [Music] {
//    guard let url = Bundle.main.url(forResource: "music", withExtension: "json") else {
//        print("Failed to locate music.json in bundle.")
//        return []
//    }
//    
//    do {
//        let data = try Data(contentsOf: url)
//        let decoder = JSONDecoder()
//        let musicList = try decoder.decode([Music].self, from: data)
//        return musicList
//    } catch {
//        print("Failed to load or decode data: \(error)")
//        return []
//    }
//}
