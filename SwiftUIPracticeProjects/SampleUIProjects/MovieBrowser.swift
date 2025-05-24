//
//  MovieBrowser.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 17/04/25.
//

import SwiftUI

struct MovieBrowser: View {
    @StateObject private var movieViewModel: MovieBrowserViewModel = MovieBrowserViewModel(service: MovieService())
    var body: some View {
        NavigationStack {
            List {
                ForEach(movieViewModel.movieList) { movie in
                    NavigationLink {
                        MovieDetailView(movie: movie)
                    } label: {
                        VStack (alignment: .leading) {
                            ZStack(alignment: .bottomLeading) {
                                AsyncImage(url: URL(string: movie.poster), content: { image in
                                    image.resizable()
                                        .frame(width: 300, height: 200)
                                        .scaledToFill()
                                        .clipped()
                                        .cornerRadius(5.0)
                                        .shadow(radius: 10)
                                    
                                }, placeholder: {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 300, height: 200)
                                        .scaledToFit()
                                })
                                
                                Text(movie.title)
                                    .foregroundColor(.white)
                                    .font(.system(size: 30).bold())
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                    .background{
                                        Rectangle()
                                            .foregroundColor(Color.black)
                                            .opacity(0.8)
                                    }
                                    .padding(.leading, 5)
                            }
                            Text("Released: \(movie.year)")
                                .font(.system(size: 20).bold())
                            Text("Type: \(movie.type)")
                                .font(.system(size: 15).bold())
                        }
                    }
                }
            }.navigationTitle("Movies")
                .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $movieViewModel.selectedMovie)
            .task(id: movieViewModel.selectedMovie) {
                await movieViewModel.fetchMovie(name: movieViewModel.selectedMovie)
            }
        }
    }
}

#Preview {
    MovieBrowser()
}
