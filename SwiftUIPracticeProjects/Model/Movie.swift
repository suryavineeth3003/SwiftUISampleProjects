//
//  Movie.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 18/04/25.
//

import Foundation

struct Movie : Codable, Identifiable {
    var id: UUID = UUID()
    let title:String
    let year: String
    let type: String
    let poster: String
    let imdbID: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
        case imdbID
    }
}

struct MovieList : Codable {
    let search: [Movie]
    
    enum CodingKeys:String, CodingKey {
        case search = "Search"
    }
}
