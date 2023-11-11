//
//  RoboKassaWebViewManager.swift
//  CardioCheck
//
//  Created by Senior Developer on 03.11.2023.
//  Copyright © 2023 Fideware. All rights reserved.
//
import Foundation
import Architecture

public final class RoboKassaWebViewManager: ViewManager<RoboKassaWebView> {
    
    var viewProperties: RoboKassaWebView.ViewProperties?
    
    //MARK: - Main state view Manager
	public enum State {
        case createViewProperties(RoboKassaWebView.ViewProperties)
    }
    
    public var state: State? {
        didSet { self.stateManager() }
    }
    
    private func stateManager(){
        guard let state = self.state else { return }
        switch state {
			case .createViewProperties(let viewProperties):
				self.viewProperties = viewProperties
				self.create?(self.viewProperties)
        }
    }
}
