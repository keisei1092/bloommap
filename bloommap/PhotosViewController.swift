//
//  PhotosViewController.swift
//  bloommap
//
//  Created by Keisei Saito on 2018/03/24.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import UIKit
import TwitterKit

class PhotosViewController: TWTRTimelineViewController {

	var spotName: String?

	override func viewDidLoad() {
		super.viewDidLoad()
		title = spotName!
		dataSource = TWTRSearchTimelineDataSource(searchQuery: "\(spotName!) filter:media", apiClient: TWTRAPIClient())
	}

}
