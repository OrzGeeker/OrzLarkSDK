//
//  Message+Type.swift
//
//
//  Created by joker on 2023/12/1.
//

import Foundation

enum `Type`: String, Codable {
    case unknown
    case text
    case post
    case image
    case shareChat = "share_chat"
    case interactive
}
