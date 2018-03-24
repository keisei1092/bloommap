//
//  SpotViews.swift
//  bloommap
//
//  Created by Keisei Saito on 2018/03/24.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import MapKit

class SpotMarkerView: MKMarkerAnnotationView {
	override var annotation: MKAnnotation? {
		willSet {
			guard let spot = newValue as? Spot else { return }
			canShowCallout = true
			calloutOffset = CGPoint(x: -5, y: 5)

			let cameraButton = UIButton(frame: CGRect(origin: CGPoint.zero,
													size: CGSize(width: 30, height: 30)))
			cameraButton.setBackgroundImage(#imageLiteral(resourceName: "camera-icon"), for: UIControlState())
			rightCalloutAccessoryView = cameraButton

			markerTintColor = spot.markerTintColor
			glyphText = "🌸"
		}
	}
}

