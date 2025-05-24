//
//  MovieDetail.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 19/04/25.
//

import Foundation
struct MovieDetail: Codable {
    let title: String
    let year: String
    let rated: String
    let released: String
    let runTime: String
    let genere: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let language: String
    let country: String
    let awards: String
    let poster: String
    let ratings:[Rating]
    
    enum CodingKeys:String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runTime = "Runtime"
        case genere = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
    }
    
}

struct Rating: Codable, Identifiable {
    let id = UUID()
    let source: String
    let value: String
    
    enum CodingKeys:String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
