//
//  MainUIViewController.swift
//  ios-app
//
//  Created by Elijah Gnuse on 4/25/23.
//

import UIKit
import MapKit

class MainUIViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coordinate = CLLocationCoordinate2D(
            latitude: 41.252856, longitude: -96.010055)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        setLocations()
        // Do any additional setup after loading the view.
    }
    
    func setLocations() {
        // TODO: Dummy data, fill with cow locs
        let testLocation = MKPointAnnotation()
        testLocation.title = "cow place"
        testLocation.coordinate = CLLocationCoordinate2D(latitude: 41.252856, longitude: -96.010055)
        mapView.addAnnotation(testLocation)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
