//
//  MovieDetailService.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 19/04/25.
//

import Foundation
import Combine

class MovieDetailService: MovieDetailServiceProtocol {

    var session: MovieAPISession
    private var cancellables = Set<AnyCancellable> ()
    init(session: MovieAPISession = URLSession.shared) {
        self.session = session
    }
    
    func fetchMovieDetail(id: String) async throws -> Result<MovieDetail, MovieError> {
        return try await withCheckedThrowingContinuation { continuation in
            guard let url = MovieAPI.detail(id: id).url else {
                continuation.resume(throwing: MovieError.invalidUrl)
                return
            }
            self.session.dataTaskPublisher(for: url)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break;
                    case .failure(let error):
                        continuation.resume(throwing: MovieError.emptyData)
                    }
                } receiveValue: { (data: Data, response: URLResponse) in
                    do {
                        print("\(String(data: data, encoding: .utf8))")
                        let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                        continuation.resume(returning: .success(movieDetail))
                    } catch {
                        print("\(error.localizedDescription))")
                        continuation.resume(throwing: error)
                    }
                }.store(in: &cancellables)
        }
    }
}

