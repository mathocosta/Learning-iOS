//
//  MapSearchViewController.swift
//  LearnMapKit
//
//  This is an example of how to use MKLocalSearch to do searches of places close to a location.
//
//  Created by Matheus Costa on 10/10/18.
//  Copyright © 2018 Matheus Costa. All rights reserved.
//

import UIKit
import MapKit

class MapSearchViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var locationManager = CLLocationManager()
    var searchCompleter = MKLocalSearchCompleter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.showsUserLocation = true
        
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.searchCompleter.delegate = self
    }
    
    /// Make a search based on a query passed by parameter.
    ///
    /// - Parameter query: query to search
    func makeSearch(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = self.mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            if let mapItems = response?.mapItems {
                if mapItems.count == 0 {
                    print("-- No matches found --")
                } else {
                    print("-- Matches found --")
                    
                    for item in mapItems {
                        print("Item: \(item)")
                    }
                }
            }
        }
    }

}

// - MARK: CLLocationManagerDelegate implementation.
extension MapSearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            let region = MKCoordinateRegion(center: lastLocation.coordinate,
                                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setCenter(lastLocation.coordinate, animated: true)
            self.mapView.setRegion(region, animated: true)
        }
    }
}

// - MARK: UISearchBarDelegate implementation.
extension MapSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchCompleter.queryFragment = searchText
        self.searchCompleter.region = self.mapView.region
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = self.searchBar.text, !query.isEmpty else {
            return
        }
        self.makeSearch(query: query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}

// - MARK: MKLocalSearchCompleterDelegate implementation.
extension MapSearchViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        print(completer.results)
    }
}
