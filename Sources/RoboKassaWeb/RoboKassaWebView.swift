//
//  RoboKassaWebView.swift
//  CardioCheck
//
//  Created by Senior Developer on 03.11.2023.
//  Copyright © 2023 Fideware. All rights reserved.
//
import UIKit
import WebKit
import Architecture

public final class RoboKassaWebView: UIView, ViewProtocol {
    
	public struct ViewProperties {
		let addWKWebView: Closure<UIView>
    }
	
    var viewProperties: ViewProperties?
    
	public func update(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
    }
	
	public func create(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
		self.viewProperties?.addWKWebView(self)
    }
}
