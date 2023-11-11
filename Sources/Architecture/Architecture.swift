//
//  Architecture.swift
//
//
//  Created by Senior Developer on 08.11.2023.
//

import UIKit

public protocol BuilderProtocol: AnyObject {
	
	associatedtype V : ViewProtocol
	associatedtype VM: ViewManager<V>
	
	var viewManager: VM { get set }
	var view       : V  { get set }
}

public typealias ClosureReturn<T> = (() -> T)
public typealias Closure<T>       = ((T) -> Void)
public typealias ClosureEmpty     = (() -> Void)
public typealias ClosureTwo<T, G> = ((T, G) -> Void)
public typealias ClosureAny       = ((Any?) -> Void)

open class ViewManager<View: ViewProtocol> {

	public var update: Closure<View.ViewProperties?>?
	public var create: Closure<View.ViewProperties?>?

	// MARK: - Привязываем View с ViewModel
	public func bind(with view: View) {
		self.update = view.update(with:)
		self.create = view.create(with:)
	}

	public init(){}
}

public protocol ViewProtocol where Self: AnyObject {
	
	associatedtype ViewProperties
	
	func create(with viewProperties: ViewProperties?)
	func update(with viewProperties: ViewProperties?)
}

