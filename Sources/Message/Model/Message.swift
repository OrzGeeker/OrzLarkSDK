//
//  Message.swift
//
//
//  Created by joker on 11/30/23.
//
// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public final class Message: Codable {

    var type: `Type` = .unknown

    var content: Content?

    var card: Card?

    enum CodingKeys: String, CodingKey {
        case type = "msg_type"
        case content
        case card
    }
}


