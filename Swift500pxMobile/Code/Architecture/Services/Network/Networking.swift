//
//  Networking.swift
//  Swift500pxMobile
//
//  Created by Timur Kuchkarov on 05.03.17.
//  Copyright © 2017 Timur Kuchkarov. All rights reserved.
//

import Foundation
import Moya
import ReactiveCocoa
import ReactiveSwift

typealias ListUpdate<T> = ([T], String?) -> ()

class Networking {
	let provider: MoyaProvider<PXAPI>
	init() {
		self.provider = MoyaProvider<PXAPI>()
	}
	func fetchPhotos(page:Int64, category: String, completion:@escaping ListUpdate<PhotoModel>) {
		self.provider.request(.photos(page: page, category: category)) { result in
			switch result {
			case let .success(moyaResponse):
				let data = moyaResponse.data
				let statusCode = moyaResponse.statusCode

				if statusCode > 399 {
					completion([], "Error detected")
					return
				}

				let parsed: [PhotoModel]? = try? unbox(data: data, atKeyPath: "photos", allowInvalidElements: false)
				if parsed != nil {
					completion(parsed!, nil)
				} else {
					completion([], "Parse error")
				}

			// do something with the response data or statusCode
			case let .failure(error):
				guard let error = error as? CustomStringConvertible else {
					completion([], "Unknown error")
					break
				}
				completion([], error.description)
				// this means there was a network failure - either the request
				// wasn't sent (connectivity), or no response was received (server
				// timed out).  If the server responds with a 4xx or 5xx error, that
				// will be sent as a ".success"-ful response.
			}
		}
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
				Constants.API.ParametersKeys.apiKey: Constants.API.apiKey,
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
