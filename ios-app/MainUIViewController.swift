//
//  MainUIViewController.swift
//  ios-app
//
//  Created by Elijah Gnuse on 4/25/23.
//

import UIKit
import MapKit
import FuzzyFind

// Controls the primary map page of the application.
class MainUIViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate {
    
    /*
    // MARK: - Controller Setup & Vars
    */
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate our map view to use "func mapView"'s (below) to handle interactions
        mapView.delegate = self
        // Same idea, search bar text change delegation.
        searchBar.delegate = self
        
        // Set map location
        let coordinate = CLLocationCoordinate2D(
            latitude: 41.252856, longitude: -96.010255)
        let span = MKCoordinateSpan(latitudeDelta: 0.011, longitudeDelta: 0.011)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        // Draw cows onto map as cow markers.
        setCowMarkers()
    }
    
    /*
    // MARK: - Utility functions
    */
    
    // Displays all cows matching search term.
    // "" matches all cows.
    private func setCowMarkers(_ searchTerm: String = "") {
        let con = DatabaseConnection()
        
        mapView.removeAnnotations(mapView.annotations)
        
        for cow in con.readAllRecords() {
            
            if bestMatch(query: searchTerm, input: cow.cowId) == nil {continue}
            
            let cowLocation = MKPointAnnotation()
            cowLocation.title = cow.cowId
            cowLocation.coordinate = CLLocationCoordinate2D(latitude: cow.latitude, longitude: cow.longitude)
            
            mapView.addAnnotation(cowLocation)
        }
    }

    /*
    // MARK: - Delegates
    */
    
    // Handles touch events for annotations, segues to edit page
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Handle the annotation selection
        if let annotation = view.annotation as? MKPointAnnotation {
            performSegue(withIdentifier: "ToCowEdit", sender: annotation.title!)
        }
    }
    
    // Exists to prevent pins from "clustering" — hiding behind eachother.
    // (Makes pins stay _always_ visible)
    // Also ensure icons and label show up properly
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        if annotation is MKPointAnnotation {
            // Use our custom annotation view
            let view = NonClusteringMKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "CustomAnnotation")
            view.setTitle((annotation.title ?? "") ?? "")
            return view
        }
        
        return nil
    }
    
    // Search runs on each text change, displaying all fuzzy-matches.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text {
            // Trim input and search
            setCowMarkers(searchText.trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
    
    /*
    // MARK: - Navigation
    */
    
    // Segue to cow edit
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCowEdit" {
            if let destinationVC = segue.destination as? EditCowViewController,
               let cowName = sender as? String {
                destinationVC.originalCowName = cowName
            }
        }
    }
}
