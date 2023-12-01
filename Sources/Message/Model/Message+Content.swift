//
//  Message+Content.swift
//  
//
//  Created by joker on 2023/12/1.
//

import Foundation


struct Content: Codable {
    
    var text: String?
    
    struct Post: Codable {
        
        struct Body: Codable {
            
            enum Tag: String, Codable {
                case text
                case a
                case at
                case img
            }
            
            struct Part: Codable {
                let tag: Tag
                var text: String?
                var href: String?
                var userId: String?
                var userName: String?
                var imageKey: String?
            }
            
            var title: String?
            
            var content: [[Part]]
        }
        
        var zh_cn: Body?
        
        var en_us: Body?
    }
    
    var post: Post? = nil
    
    var shareChatId: String?
    
    var imageKey: String?
}
