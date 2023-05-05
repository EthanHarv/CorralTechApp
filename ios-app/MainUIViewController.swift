//
//  MainUIViewController.swift
//  ios-app
//
//  Created by Elijah Gnuse on 4/25/23.
//

import UIKit
import MapKit
import FuzzyFind

class MainUIViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchBar: UISearchBar!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate our map view to use "func mapView" (below) to handle interactions
        mapView.delegate = self
        searchBar.delegate = self
            
        // Considerig these
//        mapView.isZoomEnabled = false
//        mapView.isScrollEnabled = false
        
        // Set map location
        let coordinate = CLLocationCoordinate2D(
            latitude: 41.252856, longitude: -96.010055)
        let span = MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        setCowLocations()
    }
    
    func setCowLocations() {
        let con = DatabaseConnection()
        print("NUMBER REC", con.readAllRecords().count)
        
        mapView.removeAnnotations(mapView.annotations)

        
        for cow in con.readAllRecords() {
            let cowLocation = MKPointAnnotation()
            cowLocation.title = cow.cowId
            cowLocation.coordinate = CLLocationCoordinate2D(latitude: cow.latitude, longitude: cow.longitude)
            
            mapView.addAnnotation(cowLocation)
        }
    }
    
    func searchCowLocations(_ term: String) {
        let con = DatabaseConnection()
        print("NUMBER REC", con.readAllRecords().count)
        
        mapView.removeAnnotations(mapView.annotations)
        
        for cow in con.readAllRecords() {
            
            if bestMatch(query: term, input: cow.cowId) == nil {continue}
            
            let cowLocation = MKPointAnnotation()
            cowLocation.title = cow.cowId
            cowLocation.coordinate = CLLocationCoordinate2D(latitude: cow.latitude, longitude: cow.longitude)
            
            mapView.addAnnotation(cowLocation)
        }
    }

    
    // Handles touch events for annotations
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Handle the annotation selection
        if let annotation = view.annotation as? MKPointAnnotation {
            performSegue(withIdentifier: "ToCowEdit", sender: annotation.title!)
        }
    }
    
    // Exists to prevent pins from "clustering" — hiding behind eachother.
    // (Makes pins stay _always_ visible)
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        if annotation is MKPointAnnotation {
            let view = NonClusteringMKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "CustomAnnotation")
            view.setTitle((annotation.title ?? "") ?? "")
            return view
        }
        
        return nil
    }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text {
            if searchText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                setCowLocations()
                return
            }
            // Perform the search with the searchText
            print("Search for: \(searchText)")
            searchCowLocations(searchText)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Segue to cow edit
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCowEdit" {
            if let destinationVC = segue.destination as? EditCowViewController,
               let cowName = sender as? String {
                // Use the dataReceived in your destination view controller
                destinationVC.originalCowName = cowName
            }
        }
    }


}
