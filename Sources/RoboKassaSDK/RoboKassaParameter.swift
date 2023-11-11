//
//  RoboKassaParameter.swift
//  RoboKassaSDK
//
//  Created by RoboKassa on 01.11.2023.
//
import Extensions
import Foundation

public enum RoboKassaParameter: String, CaseIterable {
	
	case MerchantLogin
	case OutSum
	case InvId
	case Description
	case SignatureValue
	case test = "IsTest"
	case Email
	case shp_order_id
	case shp_user_id
	
	func key() -> String  {
		return self.rawValue
	}
	
	func value(
		isTest: Bool,
		invId: String,
		totalPrice: String,
		signatureService: SignatureService,
		orderID: String,
		userID: String
	) -> String {
		switch self {
			case .MerchantLogin:
				return "WmFuamFiaWw=".decode64ToString()
			case .OutSum:
				return totalPrice
			case .InvId:
				return invId
			case .Description:
				return ""
			case .SignatureValue:
				signatureService.createPayment(
					with: isTest,
					invId: invId,
					totalPrice: totalPrice,
					orderID: orderID,
					userID: userID
				)
				return signatureService.signaturePayment
			case .test:
				return isTest ? "1" : "0"
			case .Email:
				return "roboKassa@gmail.com"
			case .shp_order_id:
				return orderID
			case .shp_user_id:
				return userID
		}
	}
}
