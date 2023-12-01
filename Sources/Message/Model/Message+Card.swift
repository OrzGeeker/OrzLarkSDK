//
//  Message+Card.swift
//  
//
//  Created by joker on 2023/12/1.
//

import Foundation

struct Card: Codable {
    
    struct Header: Codable {
        
        struct Title: Codable {
            
            enum Tag: String, Codable {
                case plainText = "plain_text"
            }
            
            let tag: Tag
            
            let content: String
        }
        
        let title: Title
    }
    
    var header: Header
    
    struct Element: Codable {
        
        enum Tag: String, Codable {
            case div
            case larkMarkdown = "lark_md"
            case button
            case action
        }
        
        let tag: Tag
        
        struct Text: Codable {
            let tag: Tag
            let content: String
        }
        
        var text: Text?
        
        struct Action: Codable {
            
            let tag: Tag
            
            let text: Text
            
            let url: String
            
            enum `Type`: String, Codable {
                case `default`
            }
            
            let type: Type
            
            let value: [String: String]
        }
        
        var actions: [Action]?
    }
    
    var elements: [Element]

}
