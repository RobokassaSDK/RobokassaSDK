//
//  RoboKassaWebViewVCManager.swift
//  RoboKassaSDK
//
//  Created by RoboKassa on 01.11.2023.
//
import Foundation
import Architecture

final class RoboKassaWebViewVCManager: ViewManager<RoboKassaWebViewVC> {
    
    var viewProperties: RoboKassaWebViewVC.ViewProperties?
    
    //MARK: - Main state view model
    enum State {
        case createViewProperties(RoboKassaWebViewVC.ViewProperties)
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
