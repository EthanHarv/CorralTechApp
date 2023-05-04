//
//  NonClusteringMKMarkerAnnotationView.swift
//  ios-app
//
//  Created by Ethan Harvey on 5/4/23.
//

import UIKit
import MapKit

class NonClusteringMKMarkerAnnotationView: MKMarkerAnnotationView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override var annotation: MKAnnotation? {
        willSet {
            displayPriority = MKFeatureDisplayPriority.required
        }
    }

}
