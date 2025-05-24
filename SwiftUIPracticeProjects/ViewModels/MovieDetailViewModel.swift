//
//  MovieDetailViewModel.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 19/04/25.
//

import Foundation

protocol MovieDetailServiceProtocol {
    func fetchMovieDetail(id: String) async throws -> Result<MovieDetail,MovieError>
}
class MovieDetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetail?
    @Published var errorDesctprion: String = ""
    @Published var selectedMovie: String = "Avengers"

    let service: MovieDetailServiceProtocol
    
    init(service: MovieDetailServiceProtocol) {
        self.service = service
    }
    
    var title: String {
        return movieDetail?.title ?? ""
    }
    
    var year: String {
        return movieDetail?.year ?? ""
    }
    
    var releasedDate: String {
        return movieDetail?.released ?? ""
    }
    
    var runtime: String {
        return movieDetail?.runTime ?? ""
    }
    
    var description: String {
        return movieDetail?.plot ?? ""
    }
    
    var ratings: [Rating] {
        return movieDetail?.ratings ?? []
    }
    
    @MainActor
    func fetchMovieDetail(id: String) async {
        do {
          let result = try await service.fetchMovieDetail(id: id)
            switch result {
            case .success(let movieDetail):
                self.movieDetail = movieDetail
            case .failure(let failure):
                self.errorDesctprion = "Failed to load movies"
            }
        } catch {
            self.errorDesctprion = error.localizedDescription
        }
    }
    
}
