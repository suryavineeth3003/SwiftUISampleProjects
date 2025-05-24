//
//  WeatherApp.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 17/04/25.
//

import SwiftUI
/*
-------------------------
|       🌤               |
|     23° C              |
|   Sunny, Bangalore     |
-------------------------
 
 */

struct WeatherApp: View {
    @StateObject private var viewmodel: WeatherViewModel = WeatherViewModel(weatherService: WeatherService())
    @State private var selectedCity: String = "Bangalore"
    var body: some View {
        VStack (alignment: .center) {
            Picker("Select City",selection: $selectedCity) {
                ForEach(viewmodel.cities, id: \.self) { city in
                    Text(city)
                }
            }
            .pickerStyle(.menu)
            .task(id: selectedCity) {
                await viewmodel.fetchWeather(city: selectedCity)
            }
            
            AsyncImage(url: viewmodel.iconUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                case .failure(let error):
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                }
            }
            Text("\(viewmodel.currentTemp)")
            Text("\(viewmodel.currentCondition), \(viewmodel.currentCity)")
            Spacer()
        }
    }
}

#Preview {
    WeatherApp()
}
