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
    let weatherDataModel = WeatherDataModel()
    
    
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
     // ASync Method -
    
    func getWeatherData(url: String, paramerters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: paramerters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Sucess Got the weather Data")
                
                // now what next is here
                //creating new constant that's the JSON ;
                let weatherJSON: JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
                
            } else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
                
            }
        }
        
    }

     
     //MARK: - JSON Parsing
     /***************************************************************/
    
     
     //Write the updateWeatherData method here:
    func updateWeatherData(json: JSON) {
        
        if let tempResults = json["main"] ["temp"].double {
        weatherDataModel.temperature = Int(tempResults - 273.15)
        
        weatherDataModel.city = json["name"].stringValue
        
        weatherDataModel.condition = json["weather"] [0] ["id"].intValue
   
        weatherDataModel.weatherIcon = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            updateUIwithWeatherData()
            
        } else {
            cityLabel.text = "Weather Unavailable"
        }
    }
     

     
     
     
     //MARK: - UI Updates
     /***************************************************************/
     
     
     //Write the updateUIWithWeatherData method here:
     
    func updateUIwithWeatherData() {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = String(weatherDataModel.temperature) + "º"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIcon)
    }
     
     
     
     
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
            
            //Call getWeatherData Func
            getWeatherData(url: WEATHER_URL, paramerters: params)
            
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
