//
//  ViewController.swift
//  My Location
//
//  Created by Mahmoud Hamad on 1/12/16.
//  Copyright © 2016 Mahmoud SMGL. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    //@IBOutlet weak var latitudeText: UITextField!
    //@IBOutlet weak var longitudeText: UITextField!
    
    @IBOutlet weak var latitudeButton: UIButton!
    @IBOutlet weak var longitudeButton: UIButton!
    
    
    var latitudeTextField: UITextField!
    var longitudeTextField: UITextField!
    
    var latitude = 0.000
    var longitude = 0.000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.delegate = self
        locationManager.delegate = self
        
        //Get Users Location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //users excact location
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() //turn on the location manager look for location
        
        

        latitudeButton.setTitle("Latitude", forState: .Normal)
        longitudeButton.setTitle("Longitude", forState: .Normal)

        latitudeLabel.text = "La: \(Float(mapView.region.center.latitude))"
        longitudeLabel.text = "Lo: \(Float(mapView.region.center.longitude))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let center = CLLocationCoordinate2DMake((location?.coordinate.latitude)!, (location?.coordinate.longitude)!)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)) //region the place thats zoomed the less the number the closer it is
        
        mapView.setRegion(region, animated: true)

        
        self.locationManager.stopUpdatingLocation()
        
        mapView.showsUserLocation = true

    }
    
    func CurrentLocation() {
        
    }

    @IBAction func currentLocationTapped(sender: AnyObject) {
        
        //        //Get Users Location
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest //users excact location
        //locationManager.requestWhenInUseAuthorization()
        //locationManager.startUpdatingLocation() //turn on the location manager look for location
        
        let location = locationManager.location?.coordinate
        
        print(location)
        
        let center = CLLocationCoordinate2DMake((location?.latitude)!, (location?.longitude)!)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)) //region the place thats zoomed the less the number the closer it is
        
        mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
        
        
        mapView.showsUserLocation = true
        
        latitudeLabel.text = "La: \(Float(mapView.region.center.latitude))"
        longitudeLabel.text = "Lo: \(Float(mapView.region.center.longitude))"
        
        
    }

    
    @IBAction func findTapped(sender: AnyObject) {
//        var latitude = Double(latitudeText.text!)
//        var longitude = Double(longitudeText.text!)
        
        if (latitude > 0.000) && (longitude > 0.000) {
        var location = CLLocationCoordinate2DMake(Double(latitude),Double(longitude))
        var span = MKCoordinateSpanMake(0.002, 0.002) //ZOOM
        var region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        latitudeLabel.text = "La: \(Float(mapView.region.center.latitude))"
        longitudeLabel.text = "Lo: \(Float(mapView.region.center.longitude))"
        
        }else {
            
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let ac = UIAlertController(title: "This Error Found", message: error.localizedDescription, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        
    }

    
    @IBAction func latitudepressed(sender: UIButton) {
        let ac = UIAlertController(title: "Latitude", message: "Add the Latitude", preferredStyle: .Alert)
        ac.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "Add Latitude here!"
            textField.keyboardType = UIKeyboardType.DecimalPad
        }
        
        var ConfirmLatitude = UIAlertAction(title: "Confirm", style: .Default) {
            [unowned self, ac] (action: UIAlertAction?) in
            
            let answer = ac.textFields![0] as UITextField
            self.latitude = Double(answer.text!)!
            
            //if answer.text?.characters.count > 3 {
            self.latitudeButton.setTitle("La: \(self.latitude)", forState: UIControlState.Normal)
            //} else {
              //  self.latitudeButton.setTitle("Latitude", forState: .Normal)
           // }
            
            print("\(self.latitudeButton.titleLabel)")
            print("\(self.latitude)")
            print("\(answer.text)")
            
        }
        var cancel = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        
        ac.addAction(ConfirmLatitude)
        ac.addAction(cancel)
        presentViewController(ac, animated: true, completion: nil)
        
    }
    
    @IBAction func longitudepressed(sender: UIButton) {
        let ac = UIAlertController(title: "Longitude", message: "Add the Longitude", preferredStyle: .Alert)
        ac.addTextFieldWithConfigurationHandler{ (textField: UITextField!) -> Void in
            
            textField.placeholder = "Add Longitude here!"
            textField.keyboardType = UIKeyboardType.DecimalPad
            
        }
        
        var ConfirmLongitude = UIAlertAction(title: "Confirm", style: .Default) { [unowned self, ac] (action:UIAlertAction?) in
            
            let answer = ac.textFields![0] as UITextField
            self.longitude = Double(answer.text!)!
            
            //if answer.text?.characters.count > 3 {
            self.longitudeButton.setTitle("Lo: \(self.longitude)", forState: .Normal)
            //}else {
            //self.longitudeButton.setTitle("Longitude", forState: .Normal)
            //}
            
            print("\(self.longitudeButton.titleLabel)")
            print("\(answer.text)")
            print("\(self.longitude)")
            
        }
        var cancel = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        
        ac.addAction(ConfirmLongitude)
        ac.addAction(cancel)
        presentViewController(ac, animated: true, completion: nil)
        
        
    }




}

