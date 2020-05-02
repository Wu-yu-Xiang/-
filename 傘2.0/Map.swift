//
//  Map.swift
//  傘2.0
//
//  Created by chang on 2019/10/31.
//  Copyright © 2019 chang. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.activityType = .automotiveNavigation
        locationManager?.startUpdatingLocation()
    
        
        
        /*let myLocation = locationManager?.location?.coordinate
        print(myLocation?.latitude as Any)
        print(myLocation?.longitude as Any)*/
        
        
        
        if let coordinate = locationManager?.location?.coordinate{
            let xScale:CLLocationDegrees = 0.009
            let yScale:CLLocationDegrees = 0.009
            let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta:xScale)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            map.setRegion(region, animated: true)
        }
        map.userTrackingMode = .followWithHeading
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        print("_____________________________")
        print(locations[0].coordinate.latitude)
        print(locations[0].coordinate.longitude)
    }
    
    override func viewDidDisappear(_ animated: Bool) {    //離開這畫面就不用更新地址//
        locationManager?.stopUpdatingLocation()
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   }
    
    
    @IBAction func signinButtonTapped(_ sender: Any) {
        print("Sign up button tapped")
    
        let url = URL(string:  "http://kavalanwebservice.niu.edu.tw/megaliu168/WebService2.asmx/App_Number")
        
        guard let requestUrl = url else{
            fatalError()
        }
        var request = URLRequest(url:requestUrl as URL)
 
        
        let myLocation = locationManager?.location?.coordinate
        let postString:String = "location=\(String(describing: myLocation))"
        print("Send data-",postString)
        
        request.httpBody = postString.data(using: .utf8)
        request.httpMethod = "POST"
    
        let task = URLSession.shared.dataTask(with: request){
            date, response, error in
                
            guard let data = date,error == nil else{
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse,httpStatus.statusCode != 200{
                print("statusCode should be 200,but is\(httpStatus.statusCode)")
                print("response=\(String(describing: response))")
            }
            let responseString = String(data: date!, encoding: .utf8)
            print("response",responseString ?? "rest")
        }
                
        task.resume()
        
        func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
        {
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    
}



/*import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.activityType = .automotiveNavigation
        locationManager?.startUpdatingLocation()
    
        
        
        if let coordinate = locationManager?.location?.coordinate{
            let xScale:CLLocationDegrees = 0.009
            let yScale:CLLocationDegrees = 0.009
            let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta:xScale)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            map.setRegion(region, animated: true)
        }
        map.userTrackingMode = .followWithHeading
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        print("_____________________________")
        print(locations[0].coordinate.latitude)
        print(locations[0].coordinate.longitude)
    }
    
    override func viewDidDisappear(_ animated: Bool) {    //離開這畫面就不用更新地址//
        locationManager?.stopUpdatingLocation()
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   }
}*/
