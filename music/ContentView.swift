//
//  ContentView.swift
//  music
//
//  Created by Nitya Addanki on 1/30/25.
//

import SwiftUI

struct ContentView: View {
    
//    let musicList: [Music] = loadMusic()
    @Environment(AppData.self) var appdata
    
    // State variable for search text
    @State private var searchText: String = ""
    
    // Computed property to filter musicList based on search text
    var filteredMusicList: [Music] {
        if searchText.isEmpty {
            return appdata.musicTests
        } else {
            return appdata.musicTests.filter { music in
                music.title.localizedCaseInsensitiveContains(searchText) ||
                music.artist.localizedCaseInsensitiveContains(searchText) ||
                music.album.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredMusicList) { song in
                NavigationLink {
                    MusicDetailView(music: song)
                } label: {
                    MusicRowView(song: song)
                    .transition(.opacity.combined(with: .scale)) // Transition effect
                }
                .buttonStyle(PlainButtonStyle())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Music List")
            .listStyle(PlainListStyle())
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search songs, artists, or albums")
            .animation(.easeInOut, value: filteredMusicList)
        }
    }
}

#Preview {
    ContentView().environment(AppData())
}

import SwiftUI

struct MusicRowView: View {
    let song: Music
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            VStack {
                Image(song.coverImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                
                // showing ratings
//                Text("\(song.ratings ) / 5")
                
                HStack(spacing: 4) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < song.ratings ? "star.fill" : "star")
                            .resizable()
                            .foregroundColor(index < song.ratings ? .yellow : .gray)
                            .frame(width: 8, height: 8)
                    }
                }
                
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(song.title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                    
                    if song.isLike {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                }
                
                Text(song.artist)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Album: \(song.album)")
                    .font(.body)
                    .foregroundColor(.gray)
                
                Text("Release Year: \(song.releaseYear)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
