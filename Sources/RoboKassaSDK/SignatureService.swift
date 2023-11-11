//
//  SignatureService.swift
//  RoboKassaSDK
//
//  Created by RoboKassa on 01.11.2023.
//

import CryptoKit
import Foundation

public final class SignatureService {
	
	public var signaturePayment: String = ""
	public var signaturePaymentResult: String = ""
	
	public func createPayment(
		with isTest: Bool,
		invId: String,
		totalPrice: String,
		orderID: String,
		userID: String
	) {
		let password = isTest ? Constants.passwordPaymentDev : Constants.passwordPaymentProd
		let order = "shp_order_id=\(orderID)"
		let user = "shp_user_id=\(userID)"
		let signaturePayment  = "Zanjabil:\(totalPrice):\(invId):\(password):\(order):\(user)"
		self.signaturePayment = signaturePayment.encodeMD5
	}
}

private struct Constants {
	static let passwordPaymentProd = "oNzxd1TgN7EDVNv62Jc4"
	static let passwordPaymentDev = "JQWm70hZzk865AGlLaTl"
	
	static let passwordPaymentResult = "tCB45roIH65IOKpge4YG"
}

extension String {
	
	var encodeMD5: String {
		let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
		return computed.map { String(format: "%02hhx", $0) }.joined()
	}
}
