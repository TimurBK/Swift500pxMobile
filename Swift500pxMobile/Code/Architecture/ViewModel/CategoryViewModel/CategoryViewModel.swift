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
	var photos: NSMutableOrderedSet
	var page: Int64 = 1
	var loading = false
	let queue = DispatchQueue(label: "me.t-91.categoryvmqueue", qos: .userInitiated)

	init(category: String) {
		self.category = category
		self.photos = NSMutableOrderedSet()
	}

	func loadPhotos(page:Int64, completion: @escaping ListUpdate<PhotoModel>) {
		if !self.loading {
			self.loading = true
			DataManager.shared.fetchPhotos(page: page, category: self.category) { [weak self] (photos, error) in
				self?.queue.async {
					self?.merge(photos: photos)
					if photos.count > 0 {
						self?.page = page
					}
					self?.loading = false

					DispatchQueue.main.async {
						completion(photos, error)
					}
				}
			}
		}
	}

	func loadNextPage(completion: @escaping ListUpdate<PhotoModel>) {
		self.loadPhotos(page: self.page + 1, completion: completion)
	}

	func viewModelFor(index: Int) -> PhotoCellViewModel {
		let photo = self.photos[index] as! PhotoModel
		let viewModel = PhotoCellViewModel(photographerName: photo.photographerName, photoDescription: photo.photoName, imageAddress: photo.thumbnailURL)
		return viewModel
	}

	func imageDetailViewModel(for viewModel:PhotoCellViewModel) -> ImageDetailViewModel {
		return ImageDetailViewModel(imageAddress: viewModel.imageAddress, photographerName: viewModel.photographerName, photoDescription: viewModel.photoDescription)
	}

	private func merge(photos: [PhotoModel]) {
		for photoModel in photos {
			// actually find-or-create as equality and hash are based solely on identifier which should be unique
			if self.photos.contains(photoModel) {
				let index = self.photos.index(of: photoModel)
				self.photos.replaceObject(at: index, with: photoModel)
			} else {
				self.photos.add(photoModel)
			}
		}
	}
}
