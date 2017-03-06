//
//  CategoriesListViewModel.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 06.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import Foundation

import ReactiveCocoa
import ReactiveSwift

class CategoriesListViewModel {
	let title = "Categories"
	func objectForIndex(index:Int) -> String {
		return Constants.API.categories[index]
	}

	func objectsCount() -> Int {
		return Constants.API.categories.count
	}
}
