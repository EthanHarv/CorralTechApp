//
//  MainUIViewController.swift
//  ios-app
//
//  Created by Elijah Gnuse on 4/25/23.
//

import UIKit
import MapKit

class MainUIViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate our map view to use "func mapView" (below) to handle interactions
        mapView.delegate = self
        
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
        // TODO: Dummy data, fill with "actual" cow locs (from db)
        for i in 1...5 {
            // min: 41.249795, -96.014733
            // max: 41.255328, -96.004884
            let lat = Double.random(in: 41.249795 ..< 41.255328)
            let lon = Double.random(in: -96.014733 ..< -96.004884)
            
            let testLocation = MKPointAnnotation()
            testLocation.title = "cow " + String(i)
            testLocation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            mapView.addAnnotation(testLocation)
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
        return NonClusteringMKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyMarker")
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
                destinationVC.cowName = cowName
            }
        }
    }


}
