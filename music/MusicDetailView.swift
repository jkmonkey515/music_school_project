//
//  MusicDetailView.swift
//  music
//
//  Created by Nitya Addanki on 2/4/25.
//

import SwiftUI

struct MusicDetailView: View {
    @Environment(AppData.self) var appdata
    var music: Music
    
    @State private var offset: CGFloat = 0
    private let imageHeight: CGFloat = 300
    
    @Environment(\.dismiss) private var dismiss
    @State private var userRating: Int = 0
    
    var currentIndex: Int {
        appdata.musicTests.firstIndex(where: { $0.id == music.id })!
    }
    
    var body: some View {
        @Bindable var appdata = appdata
        
        ZStack(alignment: .topLeading) {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ZStack {
                        GeometryReader { geometry in
                            Image(music.coverImage)
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: self.imageHeight + (self.offset > 0 ? self.offset : 0))
                                .clipped()
                                .offset(y: self.offset > 0 ? -self.offset : 0)
                                .background(GeometryReader { geo in
                                    Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                                })
                                .ignoresSafeArea(.all, edges: .top)
                        }
                        .frame(height: imageHeight)
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // Title with Elegant Styling
                        HStack {
                            Text(music.title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.pink)
                                .padding(.bottom, 5)
                            
                            Spacer()
                            
                            FavoriteButton(isSet: $appdata.musicTests[currentIndex].isLike)
                            
                        }
                        
                        // Artist & Duration
                        HStack {
                            Label(music.artist, systemImage: "person.fill")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Label(music.duration, systemImage: "clock.fill")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Divider().padding(.vertical, 5)
                        
                        // Album Information
                        InfoRow(icon: "music.note", label: "Album", value: music.album)
                        InfoRow(icon: "guitars", label: "Genre", value: music.genre)
                        InfoRow(icon: "calendar", label: "Released", value: "\(music.releaseYear)")
                        
                        Divider().padding(.vertical, 5)
                        
                        // Description Section
                        Text(music.description)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(5)
                            .multilineTextAlignment(.leading)
                        
                        // Clickable 5-Star Rating View
                        HStack {
                            ForEach(0..<5) { index in
                                Image(systemName: index < userRating ? "star.fill" : "star")
                                    .foregroundColor(index < userRating ? .yellow : .gray)
                                    .onTapGesture {
                                        userRating = index + 1
                                        appdata.musicTests[currentIndex].ratings = userRating
                                    }
                            }
                        }
                        .padding(.top, 8)
                    }
                    .padding()
                }
            }
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.black.opacity(0.3))
                    .clipShape(Circle())
                
                
            }
            .padding(.leading, 16)
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct InfoRow: View {
    var icon: String
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Label(label, systemImage: icon)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.body)
                .fontWeight(.medium)
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


#Preview {
    MusicDetailView(music: AppData().musicTests[0])
        .environment(AppData())
}


struct FavoriteButton: View {
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundStyle(isSet ? .yellow : .gray)
        }
    }
}
