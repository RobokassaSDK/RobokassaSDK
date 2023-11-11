//
//  RoboKassaSDK.swift
//  RoboKassaSDK
//
//  Created by RoboKassa on 01.11.2023.
//

import Foundation

public final class RoboKassaSDK {
	
	// MARK: - DI
	
	private let signatureService: SignatureService
	
	init(
		signatureService: SignatureService
	) {
		self.signatureService = signatureService
	}
	
	private let host      = "https://auth.robokassa.ru/Merchant/Index.aspx?"
	private var isTest    = true
	private var invoiceID = ""
	
	public var signatureID: String {
		signatureService.signaturePaymentResult
	}
	
	public func createURLForPayment(
		isTest: Bool,
		totalPrice: String,
		userID: String,
		orderID: String
	) -> String {
		self.isTest = isTest
		let parameter = createParameter(
			with: totalPrice,
			userID: userID,
			orderID: orderID
		)
		let urlString = host + parameter
		return urlString
	}
	
	private func createParameter(
		with totalPrice: String,
		userID: String,
		orderID: String
	) -> String {
		var parameters : [String] = []
		self.invoiceID = "\(Int.random(in: 100..<100_000))"
		RoboKassaParameter.allCases.forEach { parameter in
			let value = parameter.value(
				isTest: isTest,
				invId: invoiceID,
				totalPrice: totalPrice,
				signatureService: signatureService,
				orderID: orderID,
				userID: userID
			)
			let parameter = "\(parameter.key())=\(value)"
			parameters.append(parameter)
		}
		let result = parameters.joined(separator: "&")
		return result
	}
}

