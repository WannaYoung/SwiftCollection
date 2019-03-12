//
//  FindMeController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/19.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit
import CoreLocation

class FindMeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        locationLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(geocoderLabel.snp.top).offset(-10)
            make.height.equalTo(30)
        }
        geocoderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(locationButton.snp.top).offset(-20)
            make.height.equalTo(30)
        }
        locationButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
    }
    
    func initSubviews() {
        title = "我的位置"
        view.addSubview(locationLabel)
        view.addSubview(geocoderLabel)
        view.addSubview(locationButton)
        view.backgroundColor = UIColor.background
    }

    lazy var locationLabel = UILabel(textColor: UIColor.mainText, font: UIFont.scMediumFont(size: 18), aligment: .center).then {
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
    }
    
    lazy var geocoderLabel = UILabel(textColor: UIColor.assistText, font: UIFont.scMediumFont(size: 15), aligment: .center).then {
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
    }
    
    lazy var locationButton = UIButton(type: .custom).then {
        $0.setTitle("START", for: .normal)
        $0.setTitleColor(UIColor.orange, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        $0.addTarget(self, action: #selector(findMe), for: .touchUpInside)
    }
    
    lazy var locationManager = CLLocationManager().then {
        $0.delegate = self
    }
    
    lazy var geocoder = CLGeocoder().then {_ in }
    
    @objc func findMe() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func reverseGeocode(location:CLLocation) {
        geocoder.reverseGeocodeLocation(location) { (placeMark, error) in
            guard error == nil else { return }
            let mark = placeMark?.first
            let address = mark?.addressDictionary
            let country = address?["Country"]
            let city = address?["City"]
            let street = address?["Street"]
            self.geocoderLabel.text = "\(country ?? ""),\(city ?? ""),\(street ?? "")"
        }
    }

}

extension FindMeController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last
        locationLabel.text = String(format: "lat: %.5f  lon: %.5f", currentLocation?.coordinate.latitude ?? 0.0, currentLocation?.coordinate.longitude ?? 0.0)
        reverseGeocode(location: currentLocation!)
        locationManager.stopUpdatingLocation()
    }

}
