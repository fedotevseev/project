//
//  NetworkManager.swift
//  project
//
//  Created by Федот Евсеев on 04.08.2020.
//  Copyright © 2020 Федот Евсеев. All rights reserved.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric&lang=ru"
        case .coordinate(let lat, let long):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&apikey=\(apiKey)&units=metric&lang=ru"
        }
        performRequest(withUrlString: urlString)
    }
    
    fileprivate func performRequest(withUrlString urlString: String) {
        guard let url = URL(string: urlString) else { return }
               let session = URLSession(configuration: .default)
               let task = session.dataTask(with: url) { data, response, error in
                   if let data = data {
                       if let currentWeather = self.parseJSON(withData: data) {
                           self.onCompletion?(currentWeather)
                       }
                   }
               }
               task.resume()
    }
    
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard  let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {
                return nil
            }
         return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
