//
//  Message+API.swift
//
//
//  Created by joker on 2023/12/1.
//

import Foundation

extension Message {
    
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
