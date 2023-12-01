import XCTest
@testable import OrzLarkSDK

// XCTest Documentation
// https://developer.apple.com/documentation/xctest

// Defining Test Cases and Test Methods
// https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
final class OrzLarkSDKTests: XCTestCase {
    
    let jsonEncoder: JSONEncoder = {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = [
            .prettyPrinted,
            .sortedKeys,
        ]
        return jsonEncoder
    }()
    
    let webhook = "https://open.feishu.cn/open-apis/bot/v2/hook/1b4f84ed-6c61-4226-aa0b-81fea6804f8a"
    
    let textMessage = Message.make.text("string content")
    
    let textAtAllMessage = Message.make.text(at: "all")
    
    let textAtUserMessage = Message.make.text(at: "d1535dda")
    
    func testSendTextMessage() async throws {
        
        let ret = try await textMessage.sendToLark(with: webhook)
        
        XCTAssertTrue(ret)
    }
    
    func testTextMessageEncodable() throws {
        
        let data = try jsonEncoder.encode(textMessage)
        
        let jsonString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(jsonString, """
        {
          "content" : {
            "text" : "string content"
          },
          "msg_type" : "text"
        }
        """)
    }
    
    func testSendTextAtAllMessage() async throws {
        
        let ret = try await textAtAllMessage.sendToLark(with: webhook)
        
        XCTAssertTrue(ret)
    }
    
    func testSendTextAtUserMessage() async throws {
        
        let ret = try await textAtUserMessage.sendToLark(with: webhook)
        
        XCTAssertTrue(ret)
    }
}
