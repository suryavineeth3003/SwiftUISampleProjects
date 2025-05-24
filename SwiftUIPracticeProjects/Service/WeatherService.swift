//
//  WeatherService.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 18/04/25.
//

import Foundation
import Combine


enum WeatherError: Error {
    case invalidUrl
    case unAuthorized
    case unAuthenticated
    case decodeError
    case emptyData
}

struct WeatherAPI {
    let city: String
    
    var url: URL? {
        let urlString = "https://api.weatherapi.com/v1/current.json?key=e6c55ec32f144b418e661149251804&q=\(self.city)&aqi=no"
        guard let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
}

protocol WeatherAPISession {
    func dataTaskPublisher(for url: URL) -> URLSession.DataTaskPublisher
}

extension URLSession: WeatherAPISession {}

class WeatherService: WeatherServiceProtocol {
    let session: WeatherAPISession
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    init(session: WeatherAPISession = URLSession.shared) {
        self.session = session
    }
     func fetchWeatherForCity(name: String) async throws -> Result<WeatherInfo, WeatherError> {
        return try await withCheckedThrowingContinuation { continuation in
            guard let url = WeatherAPI(city: name).url else {
                return continuation.resume(throwing: WeatherError.invalidUrl)
            }
            session.dataTaskPublisher(for: url)
                .map({$0.data})
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Received Weather Info")
                    case .failure(let error):
                        continuation.resume(throwing: WeatherError.decodeError)
                    }
                } receiveValue: { data in
                    do {
                        let string = String(data: data, encoding: .utf8)
                        let weatherInfo = try JSONDecoder().decode(WeatherInfo.self, from: data)
                        continuation.resume(returning: .success(weatherInfo))
                    } catch {
                        print("error = \(error)")
                        continuation.resume(throwing: WeatherError.decodeError)
                    }
                    
                }.store(in: &cancellables)
        }
    }
}
