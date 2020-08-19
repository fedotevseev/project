//
//  CurrentWeather.swift
//  project
//
//  Created by Федот Евсеев on 04.08.2020.
//  Copyright © 2020 Федот Евсеев. All rights reserved.
//

struct CurrentWeather {
    let cityName: String
    let temp: Int
    var tempString: String {
        return String(temp)
    }
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain"
        case 300...321: return "cloud.drizzle"
        case 500...531: return "cloud.rain"
        case 600...622: return "cloud.snow"
        case 701...781: return "smoke"
        case 800: return "sun.min"
        case 801...804: return "cloud"
        default: return "nosign"
        }
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temp = currentWeatherData.main.temp
        conditionCode = currentWeatherData.weather.first!.id
    }
}
