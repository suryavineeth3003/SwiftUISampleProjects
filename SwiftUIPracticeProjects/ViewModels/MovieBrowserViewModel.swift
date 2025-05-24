//
//  MovieBrowserViewModel.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 18/04/25.
//

import Foundation
//https://www.omdbapi.com/?i=tt3896198&apikey=bfe7b2a9&s=avengers
enum MovieError: Error {
    case invalidUrl
    case unAuthorized
    case unAuthenticated
    case decodeError
    case emptyData
}

protocol MovieBrowserServiceProtocol {
    func fetchMovie(name: String) async throws -> Result<MovieList,MovieError>
}
class MovieBrowserViewModel: ObservableObject {
    @Published var movieList: [Movie] = []
    @Published var errorDesctprion: String = ""
    @Published var selectedMovie: String = "Avengers"

    let service: MovieBrowserServiceProtocol
    
    init(service: MovieBrowserServiceProtocol) {
        self.service = service
    }
    
    @MainActor
    func fetchMovie(name: String) async {
        do {
          let result = try await service.fetchMovie(name: name)
            switch result {
            case .success(let movieList):
                self.movieList = movieList.search
            case .failure(let failure):
                self.errorDesctprion = "Failed to load movies"
            }
        } catch {
            self.errorDesctprion = error.localizedDescription
        }
    }
    
}
