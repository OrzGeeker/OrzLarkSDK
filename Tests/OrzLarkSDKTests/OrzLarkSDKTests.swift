import XCTest
@testable import OrzLarkSDK

final class OrzLarkSDKTests: XCTestCase {
    
    let jsonEncoder: JSONEncoder = {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = [
            .prettyPrinted,
            .sortedKeys,
        ]
        return jsonEncoder
    }()
    
    let message = Message(type: .text, content: .init(text: "string content"))
    
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
    
    func testSendTextMessage() async throws {
        
        let webhook = "https://open.feishu.cn/open-apis/bot/v2/hook/993294fd-10b1-4385-8a37-053ac5f7bc67"
        
        let ret = try await message.sendToLark(with: webhook)
        
        XCTAssertTrue(ret)
    }
    
    func testTextMessageEncodable() throws {
        
        let data = try jsonEncoder.encode(message)
        
        let jsonString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(jsonString, """
        {
          "content" : {
            "text" : "string content"
          },
          "type" : "text"
        }
        """)
    
    }
}
