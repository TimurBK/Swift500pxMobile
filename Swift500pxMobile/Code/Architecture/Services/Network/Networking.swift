//
//  Networking.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 05.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import Foundation
import ReactiveMoya
import Moya
import ReactiveCocoa
import ReactiveSwift

class Networking {
	let provider: ReactiveSwiftMoyaProvider<PXAPI>
	init() {
		self.provider = ReactiveSwiftMoyaProvider<PXAPI>()
	}
	func fetchPhotos(page:Int64, category: String) -> SignalProducer<Response, MoyaError> {
		return self.provider.request(.photos(page: page, category: category))
	}

}

enum PXAPI {
	case photos(page: Int64, category: String)
}

extension PXAPI : TargetType {
	public var parameterEncoding: ParameterEncoding {
		return URLEncoding.default
	}

	var baseURL: URL { return URL(string: Constants.API.Paths.baseAddress)! }
	var path : String {
		switch self {
		case .photos(_):
			return Constants.API.Paths.photosPath
		}
	}
	var method : Moya.Method {
		switch self {
		case .photos(_):
			return .get
		}
	}
	var parameters: [String: Any]? {
		switch self {
		case .photos(let page, let category):
			var params = [
				Constants.API.ParametersKeys.feature: Constants.API.ParametersValues.feature,
				Constants.API.ParametersKeys.imageSize: Constants.API.ParametersValues.imageSize,
				Constants.API.ParametersKeys.page: page,
				Constants.API.ParametersKeys.pageSize: Constants.API.ParametersValues.pageSize] as [String : Any]
			if category != Constants.API.noFilterCategory {
				params[Constants.API.ParametersKeys.categoryFilter] = category
			}
			return params
		}
	}
	var sampleData: Data {
		switch self {
		case .photos(_):
			return "{}".utf8Encoded
		}
	}
	var task: Task {
		switch self {
		case .photos(_):
			return .request
		}
	}
}

private extension String {
	var urlEscaped: String {
		return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
	}

	var utf8Encoded: Data {
		return self.data(using: .utf8)!
	}
}
