//
//  ViewController.swift
//  bloommap
//
//  Created by Keisei Saito on 2018/03/24.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class ViewController: UIViewController, MKMapViewDelegate {

	var spots: [Spot] = []
	let locationManager = CLLocationManager()

	@IBOutlet weak var map: MKMapView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		// 東京駅周辺を拡大
		let coordinate = CLLocationCoordinate2DMake(35.681333, 139.767052)
		let span = MKCoordinateSpanMake(0.1, 0.1)
		let region = MKCoordinateRegionMake(coordinate, span)
		map.setRegion(region, animated:true)

		map.register(SpotMarkerView.self,
						 forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
		loadInitialData()
		map.addAnnotations(spots)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		checkLocationAuthorizationStatus()
	}

	func checkLocationAuthorizationStatus() {
		if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
			map.showsUserLocation = true
		} else {
			locationManager.requestWhenInUseAuthorization()
		}
	}

	func loadInitialData() {
		guard let fileName = Bundle.main.path(forResource: "BloomSpot", ofType: "json")
			else { return }
		let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))

		guard
			let data = optionalData,
			let json = try? JSONSerialization.jsonObject(with: data),
			let dictionary = json as? [String: Any],
			let works = dictionary["data"] as? [[Any]]
		else { return }

		let validSpots = works.flatMap { Spot(json: $0) }
		spots.append(contentsOf: validSpots)
	}

	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
				 calloutAccessoryControlTapped control: UIControl) {
        switch control.tag {
        case SpotMarkerView.FunctionType.twitter.rawValue:
            let vc = PhotosViewController()
            vc.spotName = (view.annotation as! Spot).title!
            navigationController?.pushViewController(vc, animated: true)
        case SpotMarkerView.FunctionType.map.rawValue:
            let location = view.annotation as! Spot
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeTransit]
            location.mapItem().openInMaps(launchOptions: launchOptions)
        default: break
        }
	}

}

