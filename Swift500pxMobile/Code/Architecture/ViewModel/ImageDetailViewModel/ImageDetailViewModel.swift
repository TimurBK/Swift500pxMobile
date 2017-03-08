//
//  ImageDetailViewModel.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 06.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import Foundation

class ImageDetailViewModel {
	let imageAddress: String
	let photographerName: String
	let photoDescription: String
	init(imageAddress: String, photographerName: String, photoDescription: String) {
		self.imageAddress = imageAddress
		self.photographerName = photographerName
		self.photoDescription = photoDescription
	}
}
