//
//  GoogleMapsVC.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 03/07/2023.
//

import UIKit
import MapKit
import GooglePlaces
import GoogleMaps
import CoreLocation

class GoogleMapsVC: UIViewController, GMSAutocompleteResultsViewControllerDelegate {
    
    let locationManager = CLLocationManager()
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        setupSearchController()
        setupMapView()
        locationManager.startUpdatingLocation()
    }
}

extension GoogleMapsVC: CLLocationManagerDelegate{
    func setupMapView(){
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            // Handle denied or restricted authorization
            print("Authorization Denied")
        default:
            // Handle other authorization status cases
            print("Authorization Denied")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else { return }
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15)
        mapView.animate(to: camera)
        let marker = GMSMarker(position: location.coordinate)
        marker.map = mapView
        locationManager.stopUpdatingLocation()
    }
}
extension GoogleMapsVC{
    //MARK: - Setting up search controller
    func setupSearchController(){
          resultsViewController = GMSAutocompleteResultsViewController()
          resultsViewController?.delegate = self // Set the delegate
          searchController = UISearchController(searchResultsController: resultsViewController)
          searchController?.searchResultsUpdater = resultsViewController

          let searchBar = searchController!.searchBar
          searchBar.sizeToFit()
          searchBar.placeholder = "Search for places"
          navigationItem.titleView = searchController?.searchBar
          definesPresentationContext = true
          searchController?.hidesNavigationBarDuringPresentation = false
      }
    
   
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace){
         searchController?.isActive = false
        //let location  =  MKMapCamera(lookingAtCenter: place.coordinate, fromEyeCoordinate: place.coordinate, eyeAltitude: 100000)
        let location = GMSCameraPosition.camera(withTarget: place.coordinate, zoom: 15)
        mapView?.animate(to: location)
     }
     
     func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error){
         print("Autocomplete error: \(error.localizedDescription)")
     }
     
     func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController){
         UIApplication.shared.isNetworkActivityIndicatorVisible = true // Show loading indicator
     }
     
     func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController){
         UIApplication.shared.isNetworkActivityIndicatorVisible = false // Hide loading indicator
     }
}
