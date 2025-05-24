//
//  PhotoGridViewModel.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 03/05/25.
//

import Foundation
class PhotoGridViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    
    init() {
        self.photos = [
            Photo(url: URL(string: "https://picsum.photos/id/10/200")!),
            Photo(url: URL(string: "https://picsum.photos/id/20/200")!),
            Photo(url: URL(string: "https://picsum.photos/id/30/200")!),
            Photo(url: URL(string: "https://picsum.photos/id/40/200")!),
            Photo(url: URL(string: "https://picsum.photos/id/50/200")!),
        ]
    }
}
