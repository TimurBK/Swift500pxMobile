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
	var photos: [PhotoModel] = []

	init(category: String) {
		self.category = category
		print("CATEGORY = \(category)")
	}

	func loadPhotos(page:Int, completion: @escaping ListUpdate<PhotoModel>) {
		completion([], nil)
	}

	func viewModelFor(index: Int) -> PhotoCellViewModel {
		let photo = self.photos[index]
		let viewModel = PhotoCellViewModel(photographerName: photo.photographerName, photoDescription: photo.photoName, imageAddress: photo.thumbnailURL)
		return viewModel
	}
}
