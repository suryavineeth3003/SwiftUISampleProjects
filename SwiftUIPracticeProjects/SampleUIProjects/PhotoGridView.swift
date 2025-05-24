//
//  PhotoGridView.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 03/05/25.
//

import SwiftUI

struct PhotoGridView: View {
    @StateObject private var viewModel = PhotoGridViewModel()
    let columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 100)), count: 2)
    var body: some View {
       
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.photos) { photo in
                    AsyncImage(url: photo.url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .cornerRadius(8).clipped()
                                .cornerRadius(10)
                        case .failure:
                            Image(systemName: "photo")
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                                .background(Color.gray)
                                .cornerRadius(10).cornerRadius(10)
                        case .empty:
                            ProgressView()
                                .frame(width: 100, height: 100)
                        @unknown default:
                            EmptyView()
                        }
                            
                    }
                }
            }.padding()
        }
    }
}

#Preview {
    PhotoGridView()
}
