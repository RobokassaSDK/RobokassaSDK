//
//  RoboKassaWebViewVCBuilder.swift
//  RoboKassaSDK
//
//  Created by RoboKassa on 01.11.2023.
//
import UIKit
import Architecture

final class RoboKassaWebViewVCBuilder: BuilderProtocol {
    
    typealias V = RoboKassaWebViewVC
    typealias VM = RoboKassaWebViewVCManager
    
    public var view: RoboKassaWebViewVC
    public var viewManager: RoboKassaWebViewVCManager
    
    public static func build() -> RoboKassaWebViewVCBuilder {
        let viewController = RoboKassaWebViewVC()
        let viewManager = RoboKassaWebViewVCManager()
        viewController.loadViewIfNeeded()
        viewManager.bind(with: viewController)
        let selfBuilder = RoboKassaWebViewVCBuilder(
            with: viewController,
            with: viewManager
        )
        return selfBuilder
    }
    
    private init(
        with viewController: RoboKassaWebViewVC,
        with viewManager: RoboKassaWebViewVCManager
    ) {
        self.view = viewController
        self.viewManager = viewManager
    }
}

