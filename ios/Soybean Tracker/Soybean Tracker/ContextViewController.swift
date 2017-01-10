//
//  ContextViewController.swift
//  Soybean Tracker
//
//  Created by tom stimes on 11/7/16.
//  Copyright © 2016 iastate.mechanics. All rights reserved.
//

import UIKit
import CoreLocation

//TODO: Have lat & long textfields
//      have use now or select time option
//      is map pick possible?
class ContextViewController: ChildViewController, CLLocationManagerDelegate {

    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    var locSet = false
    
    weak var createViewController: CreateEntryViewController?
    
    let locationManager = CLLocationManager()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        super.index = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTimeToNow()
        self.getCurrentLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enterDifferentDateOnClick(_ sender: UIButton) {
        
    }
    
    @IBAction func pickLocationFromMapOnClick(_ sender: UIButton) {
        //TODO
    }
    
    //Callback for location services:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        let long = userLocation.coordinate.longitude;
        let lat = userLocation.coordinate.latitude;
        
        createViewController?.data.latitude = lat
        createViewController?.data.longitude = long
        locSet = true
        
        let latStr = String(lat)
        let longStr = String(long)

        self.latitudeTextField.text = latStr
        self.longitudeTextField.text = longStr
        
        locationManager.stopUpdatingLocation()
    }
    
    func setTimeToNow(){
        let date = Date()
        createViewController?.data.date = date
        self.timeTextField.text = Utils.stringForDate(date)
    }
    
    func getCurrentLocation() {
        //Set up location grabbing:
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func backOnClick(_ sender: UIButton) {
        createViewController?.transitionBackFrom(pageIndex: index)
    }
    
    @IBAction func nextOnClick(_ sender: UIButton) {
        createViewController?.transitionNextFrom(pageIndex: index)
    }

}
