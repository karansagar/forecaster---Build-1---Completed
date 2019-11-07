//
//  WeatherViewController.swift
//  forecaster
//
//  Created by Karan Sagar on 03/11/19.
//  Copyright © 2019 Karan. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire


class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "1cd200cd6e6f7012adbbcba1768b63a7"
    
    //TODO: Declare instance variables here
    

    let locationManager = CLLocationManager()
    
    
    // linked IBOutlets
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    //TODO:Set up the location manager here.
        
        locationManager.delegate = self // our current class ie. weather view controller
        
        //How Strong location you require ?
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        //take permission ; when in use auth. // Edit the PList. 
        locationManager.requestWhenInUseAuthorization()
        
        //Start Updating Location. it's aSync Method and works in background
        locationManager.startUpdatingLocation()
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: - Networking
     /***************************************************************/
     
     //Write the getWeatherData method here:
     

     
     
     
     
     
     //MARK: - JSON Parsing
     /***************************************************************/
    
     
     //Write the updateWeatherData method here:
     

     
     
     
     //MARK: - UI Updates
     /***************************************************************/
     
     
     //Write the updateUIWithWeatherData method here:
     
     
     
     
     
     
     //MARK: - Location Manager Delegate Methods
     /***************************************************************/
     
     
     //Write the didUpdateLocations method here:
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            print("latitude is:- \(location.coordinate.latitude) Longitude is :- \(location.coordinate.longitude)")
            
            let latitude  = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            //combine in to dictionary
            let params: [String : String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
            
        }
        
    }
     
     
     
     //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
        cityLabel.text = "Location Unavailable"
    }
     
     

     
     //MARK: - Change City Delegate methods
     /***************************************************************/
     
     
     //Write the userEnteredANewCityName Delegate method here:
     

     
     //Write the PrepareForSegue Method here
     

}
