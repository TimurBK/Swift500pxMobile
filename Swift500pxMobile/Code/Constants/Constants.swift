//
//  Constants.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 05.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import Foundation

struct Constants {
	struct API {
		struct Paths {
			static let baseAddress = "https://api.500px.com/v1/"
			static let photosPath = "photos"
		}
		struct ParametersKeys {
			static let apiKey = "consumer_key"
			static let categoryFilter = "only"
			static let pageSize = "rpp"
			static let page = "page"
			static let feature = "feature"
			static let imageSize = "image_size"
		}
		struct ParametersValues {
			static let feature = "popular"
			static let pageSize = 100
			static let imageSize = "3,4"
		}
		struct ResponseKeys {
		}
		static let apiKey = "uIiT5ry69naX1QoVjIL7A6gCqtRCm6QGeWIAnM2E"
		static let apiSecret = "GmX4Sd4RJAln2HzYLZlOuPzb8ppQwsSu2bvI5JfI"
		static let categories = ["Uncategorized", "Abstract", "Animals", "Black and White", "Celebrities", "City and Architecture", "Commercial", "Concert", "Family", "Fashion", "Film", "Fine Art", "Food", "Journalism", "Landscapes", "Macro", "Nature", "Nude", "People", "Performing Arts", "Sport", "Still Life", "Street", "Transportation", "Travel", "Underwater", "Urban Exploration", "Wedding"]
		static let noFilterCategory = "Uncategorized"
	}
	struct Navigation {
		static let categorySelectedSegue = "categorySelectedSegue"
		static let fullscreenPhotoSegue = "fullscreenPhotoSegue"
	}
	struct ReuseIdentifiers {
		static let categoryCellReuseID = "categoryCellReuseID"
		static let photoCellReuseID = "photoCellReuseID"
	}
}
