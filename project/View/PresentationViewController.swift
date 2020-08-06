//
//  PresentationViewController.swift
//  project
//
//  Created by Федот Евсеев on 03.08.2020.
//  Copyright © 2020 Федот Евсеев. All rights reserved.
//

import UIKit
import CoreLocation

class PresentationViewController: UIViewController {
    
    var networkWeatherManager = NetworkWeatherManager()
    var currentTime = CurrentTime()
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
    let userDefaults = UserDefaults.standard
    let userDefaultsKey = "presentatioinWasViewed"
    
    @IBOutlet var helloLabel: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var viewBackground: UIView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        updateHelloLabel(currentHours: currentTime)
        
        //Тестовый город
        networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: "Yakutsk"))
        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }
        view.backgroundColor = .white
        print("viewDidAppear Load")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        userDefaults.set(true, forKey: userDefaultsKey)
        self.dismiss(animated: false, completion: nil)
        
        print("viewWillDidappear closed")
    }
    
    
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.locationLabel.text = weather.cityName
            self.tempLabel.text = weather.tempString
            self.weatherIcon.image = UIImage(systemName: weather.systemIconNameString)
        }
        
    }
    
    func updateHelloLabel(currentHours: CurrentTime) {
        
        let hourString = currentHours.hour
        
        switch hourString {
        case 0..<10:
            self.helloLabel.text = "Доброе утро!"
        case 10...12:
            self.helloLabel.text = "Добрый день!"
        case 12..<18:
            self.helloLabel.text = "Добрый вечер!"
            self.view.backgroundColor = .red
        case 18...24:
            self.helloLabel.text = "Доброй ночи!"
        default:
            break
        }
        
    }
}

//MARK: - CLLocationManagerDelegate

extension PresentationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


