//
//  Observable.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import Foundation

final public class Observable<Element> {
    
    public var listener: ((Element) -> Void)?

    public var value: Element {
        didSet { listener?(value) }
    }

    public init(_ value: Element) {
        self.value = value
    }

    public func bind(listener: ((Element) -> Void)?) {
        self.listener = listener
        listener?(value)
    }
    
}
