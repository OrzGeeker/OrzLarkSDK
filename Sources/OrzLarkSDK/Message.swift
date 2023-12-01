//
//  File.swift
//  
//
//  Created by joker on 11/30/23.
//

import Foundation

final class Message: Codable {
    
    enum `Type`: String, Codable {
        case unknown
        case text
        case post
        case image
        case shareChat
        case interactive
    }
    
    var type: `Type` = .unknown
    
    struct Content: Codable {
        
        var text: String
    }
    
    var content: Content = .init(text: "")
    
    
    enum CodingKeys: String, CodingKey {
        case type = "msg_type"
        case content
    }
}

extension Message {
    
    static var make: Message {
       Message()
    }
    
    func text(_ text: String) -> Self {
        self.type = .text
        self.content.text = text
        return self
    }
    
    func text(at userId: String) -> Self {
        self.type = .text
        self.content.text = "<at user_id=\"\(userId)\"></at>"
        return self
    }
}


extension Message {
    
    enum LarkError: Error {
        case noWebhook
        case requestFailed
    }
    
    func sendToLark(with webhook: String) async throws -> Bool {
        
        guard let webhookURL = URL(string: webhook)
        else {
            throw LarkError.noWebhook
        }
        
        var request = URLRequest(url: webhookURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(self)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200
        else {
            throw LarkError.requestFailed
        }
        
        return true
    }
}
