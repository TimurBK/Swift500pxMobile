//
//  CategoryViewModel.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 06.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import Foundation

class CategoryViewModel {
	let category: String
	init(category: String) {
		self.category = category
		print("CATEGORY = \(category)")
	}
}
