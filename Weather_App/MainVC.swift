//
//  ViewController.swift
//  Weather_App
//
//  Created by Tim on 05/05/1443 AH.
//

import UIKit
import Alamofire

class MainVC: UIViewController {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var loaderActivityIndicator: UIActivityIndicatorView!
    
    var citiId = "108410"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        editButton.layer.cornerRadius = 18
        NotificationCenter.default.addObserver(self, selector: #selector(cityChanged), name: NSNotification.Name(rawValue: "cityValueChanged"), object: nil)
        
        getCitiWeatherInfo()
    }
    
    func getCitiWeatherInfo(){
        let params = ["id": citiId , "appid": "5d3c23e27f1651a147793941e58e254d"]
        
        loaderActivityIndicator.isHidden = false
        loaderActivityIndicator.startAnimating()
        
        
        AF.request("https://api.openweathermap.org/data/2.5/weather?", parameters: params, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            if let result = response.value {
        let JSONDicti = result as! NSDictionary
        let main = JSONDicti["main"] as! NSDictionary
        var temp = main["temp"] as! Double
        var pressure = main["pressure"] as! Double
        var humidity = main["humidity"] as! Double
        
        temp = temp - 272.15
        temp = Double(round(1000 * temp) / 1000)
        self.loaderActivityIndicator.stopAnimating()
                self.loaderActivityIndicator.isHidden = true
        self.tempLabel.text = "\(temp)°"
        self.pressureLabel.text = "\(pressure)°"
        self.humidityLabel.text = "\(humidity)°"
    }
  }
}
  
    @objc func cityChanged(notification: Notification){
        if let city = notification.userInfo?["city"] as? City {
            cityNameLabel.text = city.name
            citiId = city.id
            getCitiWeatherInfo()
            
    }
    }
}
