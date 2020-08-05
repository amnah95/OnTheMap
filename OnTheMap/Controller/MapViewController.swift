//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Amnah on 8/2/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadMapAnnotaions()
    }
    
}

extension MapViewController {
    
    // Loading annotaions to MapView
    func loadMapAnnotaions(){
        
        guard StudentsInfromationModel.shared.results != [] else {
            return
        }
        
        var annotations = [MKPointAnnotation]()
        
        for location in StudentsInfromationModel.shared.results {
            let long = CLLocationDegrees(location.longitude)
            let lat = CLLocationDegrees(location.latitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let mediaURL = location.mediaURL
            let firstName = location.firstName
            let lastName = location.lastName
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(firstName) \(lastName)"
            annotation.subtitle = mediaURL
            annotations.append(annotation)
        }
        self.mapView.addAnnotations(annotations)
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


