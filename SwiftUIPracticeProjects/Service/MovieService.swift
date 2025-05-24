//
//  MovieService.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 18/04/25.
//

import Foundation
import Combine

enum MovieAPI {
    case list(name: String)
    case detail(id: String)
    
    var url: URL? {
        var urlString = ""
        switch self {
        case .list(let name):
            urlString = "https://www.omdbapi.com/?i=tt3896198&apikey=bfe7b2a9&s=\(name)"
        case .detail(let id):
            urlString = "https://www.omdbapi.com/?apikey=bfe7b2a9&i=\(id)"
        }
        guard let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
}

protocol MovieAPISession {
    func dataTaskPublisher(for url: URL) -> URLSession.DataTaskPublisher
}

extension URLSession: MovieAPISession {}

class MovieService: MovieBrowserServiceProtocol {
    var session: MovieAPISession
    private var cancellables = Set<AnyCancellable> ()
    init(session: MovieAPISession = URLSession.shared) {
        self.session = session
    }
    
    func fetchMovie(name: String) async throws -> Result<MovieList,MovieError> {
        return try await withCheckedThrowingContinuation { continuation in
            guard let url = MovieAPI.list(name: name).url else {
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
                        let movieList = try JSONDecoder().decode(MovieList.self, from: data)
                        continuation.resume(returning: .success(movieList))
                    } catch {
                        print("\(error.localizedDescription))")
                        continuation.resume(throwing: error)
                    }
                }.store(in: &cancellables)
        }
    }
}
