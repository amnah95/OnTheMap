//
//  ViewLocationViewController.swift
//  OnTheMap
//
//  Created by Amnah on 8/4/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ViewLocationViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadMapAnnotaion()
    }
    
    
    @IBAction func finishButton(_ sender: Any) {
        postStudentLocation()
        self.dismiss(animated: true, completion: nil)
        
    }
}


// Extetion for map methods
extension ViewLocationViewController {
    // Loading annotaion to MapView
     func loadMapAnnotaion(){
        
        let user = UserInformationModel.shared.userInformation
             
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: user.latitude, longitude: user.longitude)
        annotation.title = "\(user.firstName) \(user.lastName)"
        annotation.subtitle = user.mediaURL
        self.mapView.addAnnotation(annotation)
        
        // Center the view to the placemark
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: user.latitude, longitude: user.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.mapView.setRegion(region, animated: true)
    }
    
    // Map annotation style
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
                    
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: kMapAnnotationPinID) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: kMapAnnotationPinID)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // Delegate method to respond to taps
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!)
            }
        }
    }
}

extension ViewLocationViewController {
    // Request to post a sudent location
    func postStudentLocation() {
        
        let userInformation = UserInformationModel.shared.userInformation
        
        PostStudentLocation.postNewStudentLocation(userInfromation: userInformation) { (responseResults, errorMessage) in
            
            // if error message is there print out error message
            guard let responseResults = responseResults else {
                return
            }
            
            // if no errror continue
            PostStudentLocationModel.shared.userLocationID = responseResults
        }
    }
}

extension ViewLocationViewController {
    // Alret Controller function
    func errorAlert (errorMessage: String)
    {
        DispatchQueue.main.async {
            let credentialsAlertController = UIAlertController(
                title: "Error",
                message: errorMessage,
                preferredStyle: .alert
            )
            credentialsAlertController.addAction(UIAlertAction(
                title: "Dismiss",
                style:UIAlertAction.Style.default
            ))
            self.present(credentialsAlertController, animated: true, completion: nil)
        }
    }
}
