//
//  ChangeCityViewController.swift
//  forecaster
//
//  Created by Karan Sagar on 03/11/19.
//  Copyright © 2019 Karan. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
    func userEnteredNewCityName(city: String)
}

class ChangeCityViewController: UIViewController {

    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    @IBAction func getWeatherButtonPressed(_ sender: UIButton) {
    
        //get the city name user entered
        let cityName = changeCityTextField.text!
        
        //if we entered a delegate set, call the method userentered new city name
        delegate?.userEnteredNewCityName(city: cityName)
        
        //Dismiss the change city viewController
        dismiss(animated: true, completion: nil)
    }
   
    
    
    //Declare the Delegare Variable here:-
    var delegate: ChangeCityDelegate?
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
