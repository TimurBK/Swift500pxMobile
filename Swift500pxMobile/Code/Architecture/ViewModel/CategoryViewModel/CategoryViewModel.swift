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
	var page: Int64 = 1
	var loading = false

	init(category: String) {
		self.category = category
	}

	func loadPhotos(page:Int64, completion: @escaping ListUpdate<PhotoModel>) {
		if !self.loading {
			print("loading page = \(page)")
			self.loading = true
			DataManager.shared.fetchPhotos(page: page, category: self.category) { (photos, error) in
				self.merge(photos: photos)
				if photos.count > 0 {
					self.page = page
				}
				self.loading = false
				completion(photos, error)
			}
		}
	}

	func loadNextPage(completion: @escaping ListUpdate<PhotoModel>) {
		self.loadPhotos(page: self.page + 1, completion: completion)
	}

	func viewModelFor(index: Int) -> PhotoCellViewModel {
		let photo = self.photos[index]
		let viewModel = PhotoCellViewModel(photographerName: photo.photographerName, photoDescription: photo.photoName, imageAddress: photo.thumbnailURL)
		return viewModel
	}

	private func merge(photos: [PhotoModel]) {
		self.photos += photos
	}
}
