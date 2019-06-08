//
//  ViewController.swift
//  LearnMapKit
//
//  Created by Matheus Costa on 10/10/18.
//  Copyright © 2018 Matheus Costa. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var pointAnnotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        // self.showMapArea_Q1(latitude: -3.743993, longitude: -38.535674)
        self.markMapPoint_Q6()
    }
    
    /// Loads the map in the specified area.
    func showMapArea_Q1(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        
        self.mapView.setRegion(region, animated: true)
    }
    
    /// Configure an annotation and adds to map.
    func markMapPoint_Q6() {
        let coordinate = CLLocationCoordinate2D(latitude: -3.743993, longitude: -38.535674)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        self.mapView.setRegion(region, animated: true)
        
        // let pointAnnotation = MKPointAnnotation()
        self.pointAnnotation.title = "IFCE"
        self.pointAnnotation.subtitle = "Apple Developer Academy"
        
        self.mapView.addAnnotation(pointAnnotation)
    }
}

// - MARK: CLLocationManagerDelegate implementation.
extension ViewController: CLLocationManagerDelegate {
    /// Executes every time you change the location.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last!
        
        let y: CLLocationDegrees = currentLocation.coordinate.latitude
        let x: CLLocationDegrees = currentLocation.coordinate.longitude
        
        CLGeocoder().reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            if let placemarks = placemarks {
                print(placemarks[0])
            }
        }
        
        self.updateLocal(latitude: y, longitude: x)
    }
    
    /// Changes the position of annotation.
    func updateLocal(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.pointAnnotation.coordinate = coordinate
        self.mapView.setCenter(coordinate, animated: true)
    }
}

// - MARK: MKMapViewDelegate implementation.
extension ViewController: MKMapViewDelegate {
    /// With this method you can change the view for annotation displayed in the MapView.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let annotationID = "annotationID"
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: annotationID)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationID)
            annotationView!.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        let pinImage = UIImage(named: "ifce")
        annotationView?.image = pinImage

        return annotationView
    }
}
