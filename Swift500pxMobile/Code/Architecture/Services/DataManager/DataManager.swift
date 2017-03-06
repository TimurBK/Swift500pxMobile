//
//  DataManager.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 05.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Moya

class DataManager {
	private let networking: Networking
	public init(networking: Networking) {
		self.networking = networking
	}

	public func fetchPhotos(page:Int64, category: String, completion:@escaping ListUpdate<PhotoModel>) {
		return self.networking.fetchPhotos(page: page, category: category, completion: completion)
	}
}
