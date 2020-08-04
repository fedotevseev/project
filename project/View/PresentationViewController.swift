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
    
    @IBOutlet var helloLabel: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var viewBackground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkWeatherManager.fetchCurrentWeather(forCity: "Moscow")

        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }
        
        view.backgroundColor = .white
        
        
        
    }
 
    
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.locationLabel.text = weather.cityName
            self.tempLabel.text = weather.tempString
            self.weatherIcon.image = UIImage(systemName: weather.systemIconNameString)
        }
        
    }
}



