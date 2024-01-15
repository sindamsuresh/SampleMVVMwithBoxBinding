//
//  Observable.swift
//  SampleMVVMBindingWithBox
//
//  Created by Suresh Sindam on 1/14/24.
//

import Foundation

class Observable<T> {
    var value: T? {
        didSet {
            lister?(value)
        }
    }
    
    
    init(value: T?) {
        self.value = value
    }
    
    private var lister: ((T?) -> Void)?
    
    func bind(lister: @escaping (T?) -> Void ) {
        self.lister = lister
        lister(value)
    }
    
}
