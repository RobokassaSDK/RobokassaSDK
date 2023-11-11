//
//  RoboKassaFeature.swift
//  RoboKassaSDK
//
//  Created by RoboKassa on 01.11.2023.
//
import SnapKit
import Delegates
import UIKit
import WebKit
import RoboKassaWeb

public struct RoboKassaFeature {
	
	private let roboKassaWebViewFeature = RoboKassaWebViewFeature()
	private let roboKassaWebViewVCBuilder = RoboKassaWebViewVCBuilder.build()
	
	private let roboKassaSDK = RoboKassaSDK(signatureService: SignatureService())
	
	public init(){}
	
	public func run(with sum: String, isTest: Bool) -> UIViewController {
		let viewProperties = RoboKassaWebViewVC.ViewProperties(
			addWKWebView: roboKassaWebViewFeature.addAndCreateWebView,
			tapForward: {}
		)
		roboKassaWebViewVCBuilder.viewManager.state = .createViewProperties(viewProperties)
		let urlString = roboKassaSDK.createURLForPayment(
			isTest: isTest,
			totalPrice: sum,
			userID: UUID().uuidString,
			orderID: UUID().uuidString
		)
		loadWebViewURL(with: URL(string: urlString)!)
		return roboKassaWebViewVCBuilder.view
	}
	
	private func loadWebViewURL(with url: URL){
		roboKassaWebViewFeature.loadWebViewURL(with: url)
	}
}
