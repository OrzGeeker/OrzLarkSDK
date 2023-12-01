//
//  File.swift
//  
//
//  Created by joker on 11/30/23.
//
// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

final class Message: Codable {
    
    enum `Type`: String, Codable {
        case unknown
        case text
        case post
        case image
        case shareChat = "share_chat"
        case interactive
    }
    
    var type: `Type` = .unknown
    
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
    
    var content: Content?
    
    enum CodingKeys: String, CodingKey {
        case type = "msg_type"
        case content
        case card
    }
    
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
    
    var card: Card?
}

extension Message {
    
    static var make: Message {
       Message()
    }
    
    func text(_ text: String) -> Self {
        self.type = .text
        self.content = .init(text: text)
        return self
    }
    
    func text(at userId: String) -> Self {
        self.type = .text
        self.content = .init(text: "<at user_id=\"\(userId)\"></at>")
        return self
    }
    
    func post(cnBody: Content.Post.Body? = nil, enBody: Content.Post.Body? = nil) -> Self {
        self.type = .post
        self.content = .init(post: .init(zh_cn: cnBody, en_us: enBody))
        return self
    }
    
    func shareChat(_ chatId: String) -> Self {
        self.type = .shareChat
        self.content = .init(shareChatId: chatId)
        return self
    }
    
    func image(_ imageKey: String) -> Self {
        self.type = .image
        self.content = .init(imageKey: imageKey)
        return self
    }
    
    func interactive(header: Card.Header, elements: [Card.Element]) -> Self {
        self.type = .interactive
        self.card = .init(header: header, elements: elements)
        return self
    }
}


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
    
    var formattedJson: String? {
        
        get throws {
            
            let data = try Self.jsonEncoder.encode(self)
            
            return String(data: data, encoding: .utf8)
            
        }
    }
    
    enum LarkError: Error {
        case noWebhook
        case requestFailed
        case responseDataParseFailed
        case responseBizError(msg: String)
    }
    
    struct LarkResponse: Codable {
        let code: Int
        let msg: String
    }
    
    func sendToLark(with webhook: String) async throws -> Bool {
        
        guard let webhookURL = URL(string: webhook)
        else {
            throw LarkError.noWebhook
        }
        
        var request = URLRequest(url: webhookURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try Self.jsonEncoder.encode(self)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200
        else {
            throw LarkError.requestFailed
        }
        
        guard let ret = try? JSONDecoder().decode(LarkResponse.self, from: data) else {
            throw LarkError.responseDataParseFailed
        }
        
        guard ret.code == 0
        else {
            throw LarkError.responseBizError(msg: ret.msg)
        }
        
        return true
    }
}
