//
//  RoboKassaUIDelegate.swift
//
//
//  Created by RoboKassa on 02.11.2023.
//

import WebKit
import Foundation

final public class RoboKassaUIDelegate: NSObject, WKUIDelegate {
	
	public func webView(
		_ webView: WKWebView,
		runJavaScriptAlertPanelWithMessage message: String,
		initiatedByFrame frame: WKFrameInfo,
		completionHandler: @escaping () -> Void
	) {
		print(message)
		completionHandler()
	}
	
	public func webView(
		_ webView: WKWebView,
		runJavaScriptTextInputPanelWithPrompt prompt: String,
		defaultText: String?,
		initiatedByFrame frame: WKFrameInfo,
		completionHandler: @escaping (String?) -> Void
	) {
		
	}
	
	public func webView(
		_ webView: WKWebView,
		contextMenuDidEndForElement elementInfo: WKContextMenuElementInfo
	) {
		
	}
	
	public func webView(
		_ webView: WKWebView,
		runJavaScriptConfirmPanelWithMessage message: String,
		initiatedByFrame frame: WKFrameInfo,
		completionHandler: @escaping (Bool
		) -> Void) {
		
	}
	
	public func webView(
		_ webView: WKWebView,
		contextMenuWillPresentForElement elementInfo: WKContextMenuElementInfo
	) {
		
	}
	
	public func webViewDidClose(_ webView: WKWebView) {
		
	}
	
	public func webView(
		_ webView: WKWebView,
		createWebViewWith configuration: WKWebViewConfiguration,
		for navigationAction: WKNavigationAction,
		windowFeatures: WKWindowFeatures
	) -> WKWebView? {
		if let frame = navigationAction.targetFrame,
		   frame.isMainFrame {
			return nil
		}
		webView.load(navigationAction.request)
		return nil
	}
}

