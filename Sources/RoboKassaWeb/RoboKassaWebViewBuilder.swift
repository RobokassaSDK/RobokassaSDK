//
//  RoboKassaWebViewBuilder.swift
//  CardioCheck
//
//  Created by Senior Developer on 03.11.2023.
//  Copyright © 2023 Fideware. All rights reserved.
//
import UIKit
import Architecture
import Extensions

public final class RoboKassaWebViewBuilder: BuilderProtocol {
    
	public typealias V = RoboKassaWebView
	public typealias VM = RoboKassaWebViewManager
    
    public var view: RoboKassaWebView
    public var viewManager: RoboKassaWebViewManager
    
    public static func build() -> RoboKassaWebViewBuilder {
        let view = RoboKassaWebView()
        let viewManager = RoboKassaWebViewManager()
        viewManager.bind(with: view)
        let selfBuilder = RoboKassaWebViewBuilder(
            with: view,
            with: viewManager
        )
        return selfBuilder
    }
    
    private init(
        with view: RoboKassaWebView,
        with viewManager: RoboKassaWebViewManager
    ) {
        self.view = view
        self.viewManager = viewManager
    }
}

