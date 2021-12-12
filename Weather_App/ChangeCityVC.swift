//
//  ChangeCityVC.swift
//  Weather_App
//
//  Created by Tim on 05/05/1443 AH.
//

import UIKit

class ChangeCityVC: UIViewController {

    var citiesArr = [
        City(name: "الرياض", id: "108410"),
        City(name: "الدمام", id: "110336"),
        City(name: "جدة", id: "105343"),
        City(name: "أبها", id: "110690")
    ]
    var citiesId = [
    "108410",
    "110336"
    ]
    var selectesCity: City?
    @IBOutlet weak var citiesPickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        citiesPickerView.delegate = self
        citiesPickerView.dataSource = self
    }
    
    @IBAction func editCityButtonClicked(_ sender: Any) {
        if let city = selectesCity {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cityValueChanged"), object: nil, userInfo: ["city": city])
            self.dismiss(animated: true, completion: nil)
    }
}
}
extension ChangeCityVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        citiesArr.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return citiesArr[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectesCity = citiesArr[row]
        
    }
}
