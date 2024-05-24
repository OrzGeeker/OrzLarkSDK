//
//  Message+Utils.swift
//
//
//  Created by joker on 2023/12/1.
//

import Foundation

extension Message {
    
    static let jsonEncoder: JSONEncoder = {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = [
            .prettyPrinted,
            .sortedKeys,
        ]
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        return jsonEncoder
    }()
    
    public var formattedJson: String? {
        
        get throws {
            
            let data = try Self.jsonEncoder.encode(self)
            
            return String(data: data, encoding: .utf8)
            
        }
    }
}
