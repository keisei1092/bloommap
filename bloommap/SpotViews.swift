//
//  SpotViews.swift
//  bloommap
//
//  Created by Keisei Saito on 2018/03/24.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import MapKit

class SpotMarkerView: MKMarkerAnnotationView {

    enum FunctionType: Int {
        case twitter = 1, map
    }

	override var annotation: MKAnnotation? {
		willSet {
			guard let spot = newValue as? Spot else { return }
			canShowCallout = true
			calloutOffset = CGPoint(x: -5, y: 5)

			let twitterButton = UIButton(frame: CGRect(origin: CGPoint.zero,
													size: CGSize(width: 30, height: 30)))
			twitterButton.setBackgroundImage(#imageLiteral(resourceName: "App-Twitter-icon"), for: UIControlState())
            twitterButton.tag = FunctionType.twitter.rawValue
			rightCalloutAccessoryView = twitterButton

            let mapButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                   size: CGSize(width: 30, height: 30)))
            mapButton.setBackgroundImage(#imageLiteral(resourceName: "Maps-icon"), for: UIControlState())
            mapButton.tag = FunctionType.map.rawValue
            leftCalloutAccessoryView = mapButton

			markerTintColor = spot.markerTintColor
			glyphText = "🌸"
		}
	}

}

