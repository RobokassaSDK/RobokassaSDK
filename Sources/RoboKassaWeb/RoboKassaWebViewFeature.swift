//
//  RoboKassaWebViewFeature.swift
//
//
//  Created by Senior Developer on 03.11.2023.
//
import WebKit
import UIKit
import SnapKit
import Delegates

public final class RoboKassaWebViewFeature {
	
	private var configurationWKWebView: WKWebView
	private let roboKassaNavigationDelegate: RoboKassaNavigationDelegate
	private let roboKassaUIDelegate: RoboKassaUIDelegate
	
	public init(
		configurationWKWebView: WKWebView = WKWebView(),
		roboKassaNavigationDelegate: RoboKassaNavigationDelegate = RoboKassaNavigationDelegate(),
		roboKassaUIDelegate: RoboKassaUIDelegate = RoboKassaUIDelegate()
	) {
		self.configurationWKWebView = configurationWKWebView
		self.roboKassaNavigationDelegate = roboKassaNavigationDelegate
		self.roboKassaUIDelegate = roboKassaUIDelegate
	}
	
	private let roboKassaWebViewBuilder = RoboKassaWebViewBuilder.build()
	
	public func addAndCreateWebView(with containerView: UIView) {
		containerView.addSubview(roboKassaWebViewBuilder.view)
		roboKassaWebViewBuilder.view.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
		let viewProperties = RoboKassaWebView.ViewProperties(
			addWKWebView: createConfigurationWKWebView
		)
		roboKassaWebViewBuilder.viewManager.state = .createViewProperties(viewProperties)
	}
	
	public func loadWebViewURL(with urlPayment: URL) {
		let urlRequest = URLRequest(url: urlPayment)
		configurationWKWebView.load(urlRequest)
		self.setupDelegate()
	}
	
	private func createConfigurationWKWebView(with containerView: UIView) {
		let configuration = WKWebViewConfiguration()
		configuration.allowsInlineMediaPlayback = true
		configuration.mediaTypesRequiringUserActionForPlayback = []
		
		self.configurationWKWebView = WKWebView(
			frame: .zero,
			configuration: configuration
		)
		
		containerView.addSubview(configurationWKWebView)
		configurationWKWebView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
	
	private func setupDelegate() {
		self.configurationWKWebView.navigationDelegate = roboKassaNavigationDelegate
		self.configurationWKWebView.uiDelegate = roboKassaUIDelegate
	}
}
