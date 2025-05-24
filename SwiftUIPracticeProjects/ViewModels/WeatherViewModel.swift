//
//  WeatherViewModel.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 18/04/25.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeatherForCity(name: String) async throws -> Result<WeatherInfo, WeatherError> 
}

class WeatherViewModel: ObservableObject {
    var cities : [String] = ["Bangalore", "Chennai", "Delhi", "Mumbai", "Canada", "Antartica"]
    let weatherService: WeatherServiceProtocol
    @Published var weatherInfo: WeatherInfo?
    @Published var errorDescription: String = ""
    
    var iconUrl: URL {
        guard let url = URL(string: "https:\(self.weatherInfo?.current.condition.icon ?? "")") else {
           return URL(string: "https://google.com")!
        }
        return url
    }
    
    var currentCondition: String {
        return self.weatherInfo?.current.condition.text ?? ""
    }
    
    var currentTemp: String {
        return "\(self.weatherInfo?.current.temp_c ?? 0.0) C"
    }
    
    var currentCity: String {
        return self.weatherInfo?.location.name ?? ""
    }
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }
    
    @MainActor
    func fetchWeather(city: String) async {
        do {
            let result  = try await weatherService.fetchWeatherForCity(name: city)
            switch result {
            case .success(let weatherInfo):
                self.weatherInfo = weatherInfo
            default: break
            }
        } catch (let error){
            self.errorDescription = error.localizedDescription
        }
    }
}
