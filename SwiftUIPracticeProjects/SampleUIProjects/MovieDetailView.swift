//
//  MovieDetailView.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 18/04/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @StateObject private var movieDetailVM: MovieDetailViewModel = MovieDetailViewModel(service: MovieDetailService())
    var body: some View {
        List {
            Section ("About") {
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: movieDetailVM.movieDetail?.poster ?? ""), content: { image in
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
                    
                    Text(movieDetailVM.title)
                            .font(.title)
                    Text(movieDetailVM.releasedDate)
                    
                    Text(movieDetailVM.description)
                        .font(.caption)
                    
                    Text(movieDetailVM.runtime)
                        .font(.caption2)
                }
            }
            
            Section("Ratings") {
                ForEach(movieDetailVM.ratings) { rating in
                    HStack {
                        Text(rating.source)
                            .font(.caption)
                        Text(rating.value)
                            .font(.caption2)
                    }
                }
            }
        }
        .task {
            await movieDetailVM.fetchMovieDetail(id: movie.imdbID)
        }
    }
}

#Preview {
    MovieDetailView(movie: Movie(title: "", year: "", type: "", poster: "", imdbID: ""))
}
