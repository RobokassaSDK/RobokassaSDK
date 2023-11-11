//
//  RoboKassaWebViewVC.swift
//  RoboKassaSDK
//
//  Created by RoboKassa on 01.11.2023.
//
import UIKit
import Combine
import Delegates
import Models
import SnapKit
import Architecture
import WebKit

final class RoboKassaWebViewVC: UIViewController, ViewProtocol {
    
	//MARK: - Main ViewProperties
	public struct ViewProperties {
		let addWKWebView: Closure<UIView>
		let tapForward: ClosureEmpty
	}
	
    var viewProperties: ViewProperties?
	
	//MARK: - Outlets
	@IBOutlet weak private var containerWebView: UIView!
	
	init() {
		super.init(nibName: String(describing: Self.self), bundle: Bundle.module)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
    
    //MARK: - Outlets
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
	//MARK: - public methods
    func update(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
    }
    
    func create(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
		self.viewProperties?.addWKWebView(self.view)
    }
}
