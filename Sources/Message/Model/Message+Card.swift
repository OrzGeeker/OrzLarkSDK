//
//  Message+Card.swift
//
//
//  Created by joker on 2023/12/1.
//

import Foundation

public struct Card: Codable {
    
    public struct Header: Codable {
        
        public struct Title: Codable {
            
            public enum Tag: String, Codable {
                case plainText = "plain_text"
            }
            
            public let tag: Tag
            
            public let content: String
            
            public init(tag: Tag, content: String) {
                self.tag = tag
                self.content = content
            }
        }
        
        public let title: Title
        
        public init(title: Title) {
            self.title = title
        }
    }
    
    var header: Header
    
    public struct Element: Codable {
        
        public enum Tag: String, Codable {
            case div
            case larkMarkdown = "lark_md"
            case button
            case action
        }
        
        public let tag: Tag
        
        public struct Text: Codable {
            public let tag: Tag
            public let content: String
            public init(tag: Tag, content: String) {
                self.tag = tag
                self.content = content
            }
        }
        
        public var text: Text?
        
        public struct Action: Codable {
            
            public let tag: Tag
            
            public let text: Text
            
            public let url: String
            
            public enum `Type`: String, Codable {
                case `default`
            }
            
            public let type: `Type`
            
            public let value: [String: String]
            
            public init(tag: Tag, text: Text, url: String, type: Type, value: [String : String]) {
                self.tag = tag
                self.text = text
                self.url = url
                self.type = type
                self.value = value
            }
        }
        
        public var actions: [Action]?
        
        public init(tag: Tag, text: Text? = nil, actions: [Action]? = nil) {
            self.tag = tag
            self.text = text
            self.actions = actions
        }
    }
    
    var elements: [Element]
    
}
