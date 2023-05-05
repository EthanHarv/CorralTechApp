//
//  NonClusteringMKMarkerAnnotationView.swift
//  ios-app
//
//  Created by Ethan Harvey on 5/4/23.
//

import UIKit
import MapKit

class NonClusteringMKMarkerAnnotationView: MKAnnotationView {
    private var titleLabel: UILabel!

    override var annotation: MKAnnotation? {
        willSet {
            displayPriority = .required
        }
    }
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupCustomImage()
        setupTitleLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCustomImage()
        setupTitleLabel()
    }

    private func setupCustomImage() {
        image = resizeImage(UIImage(named: "cow_icon"), targetSize: CGSize(width: 32, height: 32))
        canShowCallout = true
    }
    
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
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
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
