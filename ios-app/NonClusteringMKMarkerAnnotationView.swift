//
//  NonClusteringMKMarkerAnnotationView.swift
//  ios-app
//
//  Created by Ethan Harvey on 5/4/23.
//

import UIKit
import MapKit

class NonClusteringMKMarkerAnnotationView: MKAnnotationView {
    
    // Label that will display below the cow (for showing cow name/id).
    private var titleLabel: UILabel!
    
    // For external use, required for title to display below cow mark.
    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    // Override so pins will not hide behind other pins that are too close.
    override var annotation: MKAnnotation? {
        willSet {
            displayPriority = .required
        }
    }
    
    // Required Plumbing
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupCustomImage()
        setupTitleLabel()
    }

    // Required Plumbing
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCustomImage()
        setupTitleLabel()
    }

    // Configure marker to have cow image, pulls cow_icon from project assets
    private func setupCustomImage() {
        image = resizeImage(UIImage(named: "cow_icon"), targetSize: CGSize(width: 32, height: 32))
        canShowCallout = true
    }
    
    // Initialize name/id label to go below cow icon.
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        // Position the label below the annotation view
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 2)
        ])
    }
        
    // Ensures our high-quality image is properly sized.
    private func resizeImage(_ image: UIImage?, targetSize: CGSize) -> UIImage? {
        guard let image = image else {
            return nil
        }

        UIGraphicsBeginImageContextWithOptions(targetSize, false, UIScreen.main.scale)
        image.draw(in: CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage
    }
}
