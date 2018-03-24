//
//  Spot.swift
//  bloommap
//
//  Created by Keisei Saito on 2018/03/24.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Spot: NSObject, MKAnnotation {
	let title: String?
	let coordinate: CLLocationCoordinate2D

	init(title: String, coordinate: CLLocationCoordinate2D) {
		self.title = title
		self.coordinate = coordinate

		super.init()
	}

	init?(json: [Any]) {
		self.title = json[0] as? String ?? "No Title"
		if let latitude = Double(json[1] as! String),
			let longitude = Double(json[2] as! String) {
			self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		} else {
			self.coordinate = CLLocationCoordinate2D()
		}
	}

	var subtitle: String? {
		return title != nil ? title! + " の最新情報を見る" : nil
	}

	var markerTintColor: UIColor {
		return UIColor(red: 254 / 255, green: 238 / 255, blue: 237 / 255, alpha: 1)
	}

	// Annotation right callout accessory opens this mapItem in Maps app
	func mapItem() -> MKMapItem {
		let addressDict = [CNPostalAddressStreetKey: subtitle!]
		let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
		let mapItem = MKMapItem(placemark: placemark)
		mapItem.name = title
		return mapItem
	}
}
