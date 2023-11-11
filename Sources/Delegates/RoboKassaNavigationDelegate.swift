//
//  RoboKassaNavigationDelegate.swift
//
//
//  Created by RoboKassa on 02.11.2023.
//
import WebKit
import Architecture
import Foundation
import Extensions

final public class RoboKassaNavigationDelegate: NSObject, WKNavigationDelegate {
	
	public var didFinish: Closure<Bool>?
	public var didCommit: ClosureEmpty?
	public var openBanner: Closure<String?>?
	public var redirect: Closure<WKNavigationAction>?
	public var navigationResponseAction: Closure<URL?>?
	public var webViewAction: Closure<WKWebView?>?
	public var navBar: Closure<String?>?
	public var webView: WKWebView?
	public var navigationError: ClosureTwo<Int, URL?>?
	public var navigationStartError: ClosureTwo<Int, URL?>?
   
	public override init() {
		self.didFinish = nil
		self.didCommit = nil
		self.openBanner = nil
		self.redirect = nil
		self.webView = nil
	}
	
	public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		self.webView = webView
		//AmplitudeEventConstants.ON_WEBVIEW_PAGE_FINISH_LOADING(webView.url).pushEvent()
		didFinish?(true)
	}

	public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
		self.webView = webView
		didCommit?()
	}
	
	public func webView(
		_ webView: WKWebView,
		decidePolicyFor navigationAction: WKNavigationAction,
		preferences: WKWebpagePreferences,
		decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences
		) -> Void) {
		webViewAction?(webView)
		decisionHandler(.allow, preferences)
	}
	
	public func webView(
		_ webView: WKWebView,
		decidePolicyFor navigationAction: WKNavigationAction,
		decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
	) {
		self.openBanner?(navigationAction.request.url?.absoluteString)
		redirect?(navigationAction)
		decisionHandler(.allow)
	}
	
	//ошибка ВПН и Интернета
	public func webView(
		_ webView: WKWebView,
		didFailProvisionalNavigation navigation: WKNavigation!,
		withError error: Error
	) {
		if let url = webView.url, !url.isTelegram() {
			navigationError?(400, webView.url)
		}
	}
	
	public func webView(
		_ webView: WKWebView,
		decidePolicyFor navigationResponse: WKNavigationResponse,
		decisionHandler: @escaping (WKNavigationResponsePolicy
		) -> Void) {
	   
		if let url = navigationResponse.response.url, url.isTelegram() {
			UIApplication.shared.open(url)
			decisionHandler(.cancel)
		} else {
			webViewAction?(webView)
			if let response = (navigationResponse.response as? HTTPURLResponse) {
				navigationError?(response.statusCode, navigationResponse.response.url)
				navigationStartError?(response.statusCode, navigationResponse.response.url)
				print(response.statusCode, "statusCode")
			}
			decisionHandler(.allow)
		}
	}
}
