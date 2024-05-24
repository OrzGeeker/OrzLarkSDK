//
//  Message+Content.swift
//
//
//  Created by joker on 2023/12/1.
//

import Foundation


public struct Content: Codable {

    var text: String?

    public struct Post: Codable {

        public struct Body: Codable {

            public enum Tag: String, Codable {
                case text
                case a
                case at
                case img
            }

            public struct Part: Codable {
                public let tag: Tag
                public var text: String?
                public var href: String?
                public var userId: String?
                public var userName: String?
                public var imageKey: String?

                public init(tag: Tag, text: String? = nil, href: String? = nil, userId: String? = nil, userName: String? = nil, imageKey: String? = nil) {
                    self.tag = tag
                    self.text = text
                    self.href = href
                    self.userId = userId
                    self.userName = userName
                    self.imageKey = imageKey
                }
            }

            public var title: String?

            public var content: [[Part]]

            public init(title: String? = nil, content: [[Part]]) {
                self.title = title
                self.content = content
            }
        }

        var zh_cn: Body?

        var en_us: Body?
    }

    var post: Post? = nil

    var shareChatId: String?

    var imageKey: String?
}
