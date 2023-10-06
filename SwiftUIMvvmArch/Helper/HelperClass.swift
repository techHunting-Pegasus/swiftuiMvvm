//
//  HelperClass.swift
//  ApiDemoWithFuture
//
//  Created by John on 06/10/23.
//

import Foundation

protocol JsonSerilizer{
    func serilize() -> Dictionary<String,Any>
}
protocol JsonDeserializer {
    init()
    mutating func deserialize(values: Dictionary<String, Any>?)
}

struct CommonRequest: JsonSerilizer {
    
    func serilize() -> Dictionary<String, Any> {
        return [:]
    }
}
