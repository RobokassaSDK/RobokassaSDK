//
//  Extensions.swift
//  
//
//  Created by RoboKassa on 02.11.2023.
//
import Models
import UIKit

extension Bundle {
	
	public static let blah = Bundle.module
	public static let bundle = Bundle.main.bundleIdentifier
}
public extension URL {
	
	static func createWithSchemeHostPath(
		with roboKassaDataModel: RoboKassaDataModel,
		parameters: [String: String] = [:]
	) -> URL? {
		var components = URLComponents()
		components.scheme = roboKassaDataModel.scheme
		components.host = roboKassaDataModel.host
		components.path = roboKassaDataModel.path
		components.queryItems = parameters.createQueryItems()
		return components.url
	}
	
	static func createSchemeHost(
		with roboKassaDataModel: RoboKassaDataModel,
		parameters: [String: String] = [:]
	) -> URL? {
		var components = URLComponents()
		components.scheme = roboKassaDataModel.scheme
		components.host = roboKassaDataModel.host
		components.queryItems = parameters.createQueryItems()
		return components.url
	}
	
	static func create(
		with url: URL?,
		parameters: [String: String] = [:]
	) -> URL? {
		var components = URLComponents()
		components.scheme = url?.scheme
		components.host = url?.host
		components.path = url?.path ?? ""
		components.queryItems = parameters.createQueryItems()
		return components.url
	}
	
	static func createMain(
		with fullURL: URL
	) -> URL? {
		var components = URLComponents()
		components.scheme = fullURL.scheme
		components.host = fullURL.host
		components.path = fullURL.path
		return components.url
	}
	
	func isTelegram() -> Bool {
	   return ((self.host?.contains("telegram.me") == true) || (self.host?.contains("t.me") == true))
	}
}

public extension Dictionary where Iterator.Element == (key: String, value: String) {
	
	func createQueryItems() -> [URLQueryItem] {
		let result = self.map { URLQueryItem(name: $0, value: $1) }
		return result
	}
}

public extension UIView {
	
	static func loadNib() -> Self {
		let nib = Bundle.module.loadNibNamed(String(describing: Self.self), owner: nil, options: nil)?.first
		return nib as! Self
	}
}

public extension UIScrollView {
	
	func isBouncesBottom(to: CGFloat) -> Bool {
		let contentHeight  = self.contentSize.height
		let contentVisible = self.visibleSize.height
		let result = (contentHeight - contentVisible) - to
		if self.contentOffset.y >= result {
			return false
		} else {
			return true
		}
	}
	func isBouncesTop(to: CGFloat) -> Bool {
		if self.contentOffset.y <= to {
			return false
		} else {
			return true
		}
	}
	func isBottom(to: CGFloat) -> Bool {
		let contentHeight  = self.contentSize.height
		let contentVisible = self.visibleSize.height
		let result = (contentHeight - contentVisible) + to
		if self.contentOffset.y > result {
			return true
		} else {
			return false
		}
	}
	func isTop(to: CGFloat) -> Bool {
		if self.contentOffset.y < -to {
			return true
		} else {
			return false
		}
	}
}

extension UIActivityIndicatorView {
	
	func show(_ activity: Bool){
		if activity {
			self.startAnimating()
			self.isHidden = false
		} else {
			self.stopAnimating()
			self.isHidden = true
		}
	}
}

extension Int {
	
	public func toString() -> String {
		String(self)
	}
}

extension Date {
	
	func toStaring(format: String.FormatDate) -> String {
		let dateFormate = DateFormatter()
		dateFormate.dateFormat = format.rawValue
		let formatString = dateFormate.string(from: self)
		return formatString
	}
}

extension String {
	
	func getDate(formatDate: FormatDate) -> Date? {
		let formatter = DateFormatter()
		formatter.dateFormat = formatDate.rawValue
		let date = formatter.date(from: self)
		return date
	}
	
	public func decode64ToString() -> String {
		
		let decodedData = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))! as Data
		guard let decodedString = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) as String? else { return "Error" }
		return decodedString
	}
	
	enum FormatDate: String {
		case time             = "HH:mm"
		case monthDay         = "MM.dd"
		case monthDayYear     = "MM.dd.yy"
		case dayMonthYear     = "dd.MM.yy"
		case dayMonthText     = "dd MMMM"
		case dayMonthTextYear = "dd MMMM yyyy"
		case long             = "MMMM d, yyyy"
		case fcCalendar       = "yyyy-MM-dd"
		case orderDateTime    = "dd_MMMM_yyyy HH :mm :ss"
		case orderDatePath    = "dd_MMMM_yyyy/"
		case orderDate        = "dd_MMMM_yyyy"
		case longDateString   = "EEEE, MMM d, yyyy"
	}
	
	func localizable() -> String {
		NSLocalizedString(
			self,
			tableName: "Localizable",
			bundle: .main,
			value: self,
			comment: self
		)
	}
}

public extension UIView {
	static func createForXib() -> Self {
		let nib = Bundle.main.loadNibNamed(
			String(describing: Self.self),
			owner: nil,
			options: nil)?.first
		return nib as! Self
	}
}


extension UIApplication {
	public static var appVersion: String {
		let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
		return version ?? "version not"
	}
}


private class BundleFinder {}

extension Foundation.Bundle {
	/// Returns the resource bundle associated with the current Swift module.
	static let module: Bundle = {
		let bundleName = "RoboKassaSDK_RoboKassaSDK"

		let overrides: [URL]
		#if DEBUG
		// The 'PACKAGE_RESOURCE_BUNDLE_PATH' name is preferred since the expected value is a path. The
		// check for 'PACKAGE_RESOURCE_BUNDLE_URL' will be removed when all clients have switched over.
		// This removal is tracked by rdar://107766372.
		if let override = ProcessInfo.processInfo.environment["PACKAGE_RESOURCE_BUNDLE_PATH"]
					   ?? ProcessInfo.processInfo.environment["PACKAGE_RESOURCE_BUNDLE_URL"] {
			overrides = [URL(fileURLWithPath: override)]
		} else {
			overrides = []
		}
		#else
		overrides = []
		#endif

		let candidates = overrides + [
			// Bundle should be present here when the package is linked into an App.
			Bundle.main.resourceURL,

			// Bundle should be present here when the package is linked into a framework.
			Bundle(for: BundleFinder.self).resourceURL,

			// For command-line tools.
			Bundle.main.bundleURL,
		]

		for candidate in candidates {
			let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
			if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
				return bundle
			}
		}
		fatalError("unable to find bundle named RoboKassaSDK_RoboKassaSDK")
	}()
}
