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
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
    @IBOutlet var helloLabel: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var viewBackground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
        //Тестовый город
        networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: "Yakutsk"))
        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }
        
        view.backgroundColor = .white
        print("viewDidLoad")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "presentatioinWasViewed")
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


