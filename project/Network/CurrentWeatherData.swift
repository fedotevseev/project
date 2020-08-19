//
//  CurrentWeatherData.swift
//  project
//
//  Created by Федот Евсеев on 01.08.2020.
//  Copyright © 2020 Федот Евсеев. All rights reserved.
//

struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Int
}

struct Weather: Codable {
    let id: Int
}
