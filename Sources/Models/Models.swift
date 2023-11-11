//
//  Models.swift
//
//
//  Created by RoboKassa on 02.11.2023.
//

import UIKit

public struct RoboKassaDataModel: Codable {
	
	public let scheme: String
	public let host: String
	public let path: String
	public let title: String
	public let homeUrl: URL?
	public let isPresent: Bool
	public let isClose: Bool
	public let isCopyUrl: Bool
	public var urlPayment: URL?
	
	enum CodingKeys: String, CodingKey {
		
		case scheme
		case host
		case path
		case title
		case homeUrl
		case isPresent
		case isClose
		case isCopyUrl
		case urlPayment
	}
	
	public init(
		scheme: String,
		host: String,
		path: String,
		title: String,
		homeUrl: URL?,
		isPresent: Bool,
		isClose: Bool,
		isCopyUrl: Bool
	) {
		self.scheme = scheme
		self.host = host
		self.path = path
		self.title = title
		self.isPresent = isPresent
		self.isClose = isClose
		self.isCopyUrl = isCopyUrl
		self.homeUrl = homeUrl
	}
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		self.host = (try? values.decode(String.self, forKey: .host)) ?? ""
		self.scheme = (try? values.decode(String.self, forKey: .scheme)) ?? ""
		self.path = (try? values.decode(String.self, forKey: .path)) ?? ""
		self.title = (try? values.decode(String.self, forKey: .title)) ?? ""
		self.isPresent = (try? values.decode(Bool.self, forKey: .isPresent)) ?? false
		self.isClose = (try? values.decode(Bool.self, forKey: .isClose)) ?? false
		self.isCopyUrl = (try? values.decode(Bool.self, forKey: .isCopyUrl)) ?? false
		self.homeUrl = try? values.decode(URL?.self, forKey: .homeUrl)
		self.urlPayment = try? values.decode(URL?.self, forKey: .urlPayment)
	}
}

public enum PresentScreen {
	case roboKassa(UIViewController)
	case game
}

public enum RoboKassaURL {
	case roboKassa(RoboKassaDataModel)
	case error(String)
}

//struct TelegramAlert: AlertButtonOptionsoble {
//	var buttonsCount: Int = 2
//	var buttonsText: Array<String> = ["Да", "Нет"]
//}
