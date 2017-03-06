//
//  Photo.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 05.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import Foundation

struct PhotoModel {
	let photoName: String
	let identifier: Int64
	let photographerName: String
	let thumbnailURL: String
	let fullsizedURL: String
}

extension PhotoModel : Unboxable {
	init(unboxer: Unboxer) throws {
		self.identifier = try unboxer.unbox(key: "id")
		self.photoName = try unboxer.unbox(key: "name")
		self.photographerName = try unboxer.unbox(keyPath: "user.username")
		self.thumbnailURL = try unboxer.unbox(keyPath: "images.0.url")
		self.fullsizedURL = try unboxer.unbox(keyPath: "images.1.url")
	}
}
