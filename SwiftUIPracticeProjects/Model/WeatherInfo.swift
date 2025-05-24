//
//  WeatherInfo.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 18/04/25.
//

import Foundation

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
}

struct Condition: Codable {
    let text: String
    let icon: String
}

struct Current: Codable {
    let temp_c: Double
    let temp_f: Double
    let is_day: Int
    let condition: Condition
}

struct WeatherInfo: Codable {
    let location: Location
    let current: Current
}
