//
//  PhotoCellViewModel.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 06.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import Foundation

class PhotoCellViewModel {
	let photographerName: String
	let photoDescription: String
	let imageAddress: String

	init(photographerName: String, photoDescription: String, imageAddress: String) {
		self.photographerName = photographerName
		self.photoDescription = photoDescription
		self.imageAddress = imageAddress
	}
}
