import XCTest
@testable import OrzLarkSDK

// XCTest Documentation
// https://developer.apple.com/documentation/xctest

// Defining Test Cases and Test Methods
// https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
final class OrzLarkSDKTests: XCTestCase {
    
    static let userId = "ou_be45bb011eaaf304c1fa6a94242179b6"
    
    let textMessage = Message.make.text("string content")
    
    let textAtAllMessage = Message.make.text(at: "all")
    
    let textAtUserMessage = Message.make.text(at: userId)
        
    func testTextMessageEncodable() throws {
        
        XCTAssertEqual(try textMessage.formattedJson, """
        {
          "content" : {
            "text" : "string content"
          },
          "msg_type" : "text"
        }
        """)
    }
    
    func testSendTextMessage() async throws {
        
        let ret = try await textMessage.sendToLark
        
        XCTAssertTrue(ret)
    }
    
    
    func testSendTextAtAllMessage() async throws {
        
        let ret = try await textAtAllMessage.sendToLark
        
        XCTAssertTrue(ret)
    }
    
    func testSendTextAtUserMessage() async throws {
        
        let ret = try await textAtUserMessage.sendToLark
        
        XCTAssertTrue(ret)
    }
    
    
    let postMessage = Message.make.post(cnBody: .init(title: "test post", content: [
        [
            .init(tag: .text, text: "text post"),
            .init(tag: .a, text: "百度链接", href: "https://www.baidu.com"),
            .init(tag: .at, userId: userId)
        ]
    ]))
    
    func testPostMessageEncodable() throws {
        
        let ret = try postMessage.formattedJson
        
        XCTAssertEqual(ret, """
        {
          "content" : {
            "post" : {
              "zh_cn" : {
                "content" : [
                  [
                    {
                      "tag" : "text",
                      "text" : "text post"
                    },
                    {
                      "href" : "https:\\/\\/www.baidu.com",
                      "tag" : "a",
                      "text" : "百度链接"
                    },
                    {
                      "tag" : "at",
                      "user_id" : "ou_be45bb011eaaf304c1fa6a94242179b6"
                    }
                  ]
                ],
                "title" : "test post"
              }
            }
          },
          "msg_type" : "post"
        }
        """)
    }
    
    func testSendPostMessage() async throws {
      
        let ret = try await postMessage.sendToLark
        
        XCTAssertTrue(ret)
    }
    
    let shareChatMessage = Message.make.shareChat("oc_aa03b42c452ed330f6dafbdcd2fc92e7")
    
    func testShareChatMessageEncodable() throws {
        
        let ret = try shareChatMessage.formattedJson
        
        XCTAssertEqual(ret, """
        {
          "content" : {
            "share_chat_id" : "oc_aa03b42c452ed330f6dafbdcd2fc92e7"
          },
          "msg_type" : "share_chat"
        }
        """)
    }
    
    func testSendShareChatMessage() async throws {
        
        let ret = try await shareChatMessage.sendToLark
        
        XCTAssertTrue(ret)
    }
    
    let imageMessage = Message.make.image("img_v3_025n_626413ac-9e2a-43e2-bba8-df231db0e93g")
    
    func testImageMessageEncodable() throws {
        
        let ret = try imageMessage.formattedJson
        
        XCTAssertEqual(ret, """
        {
          "content" : {
            "image_key" : "img_v3_025n_626413ac-9e2a-43e2-bba8-df231db0e93g"
          },
          "msg_type" : "image"
        }
        """)
    }
    
    func testSendImageMessage() async throws {
        
        let ret = try await imageMessage.sendToLark
        
        XCTAssertTrue(ret)
    }
    
    let interactiveMessage = Message.make.interactive(
        header: .init(title: .init(tag: .plainText, content: "今日旅游推荐")),
        elements: [
            .init(
                tag: .div,
                text: .init(tag: .larkMarkdown, content: "**西湖**，位于浙江省杭州市西湖区龙井路1号，杭州市区西部，景区总面积49平方千米，汇水面积为21.22平方千米，湖面面积为6.38平方千米。")
            ),
            .init(tag: .action, actions: [
                .init(tag: .button, text: .init(tag: .larkMarkdown, content: "更多景点介绍 :玫瑰:"), url: "http://www.baidu.com", type: .default, value: [String : String]())
            ])
        ]
    )
    
    func testInteractiveMessageEncodable() throws {
        
        let ret = try interactiveMessage.formattedJson
        
        print(ret!)
        
        XCTAssertEqual(ret, """
        {
          "card" : {
            "elements" : [
              {
                "tag" : "div",
                "text" : {
                  "content" : "**西湖**，位于浙江省杭州市西湖区龙井路1号，杭州市区西部，景区总面积49平方千米，汇水面积为21.22平方千米，湖面面积为6.38平方千米。",
                  "tag" : "lark_md"
                }
              },
              {
                "actions" : [
                  {
                    "tag" : "button",
                    "text" : {
                      "content" : "更多景点介绍 :玫瑰:",
                      "tag" : "lark_md"
                    },
                    "type" : "default",
                    "url" : "http:\\/\\/www.baidu.com",
                    "value" : {

                    }
                  }
                ],
                "tag" : "action"
              }
            ],
            "header" : {
              "title" : {
                "content" : "今日旅游推荐",
                "tag" : "plain_text"
              }
            }
          },
          "msg_type" : "interactive"
        }
        """)
    }
    
    func testSendInteractiveMessage() async throws {
        
        let ret = try await interactiveMessage.sendToLark
        
        XCTAssertTrue(ret)
    }
}

/// 自定义机器人发送消息到群:
///     https://open.feishu.cn/document/client-docs/bot-v3/add-custom-bot
///
/// 支持发送的消息类型:
///     https://open.feishu.cn/document/client-docs/bot-v3/add-custom-bot#%E6%94%AF%E6%8C%81%E5%8F%91%E9%80%81%E7%9A%84%E6%B6%88%E6%81%AF%E7%B1%BB%E5%9E%8B%E8%AF%B4%E6%98%8E)
///
extension Message {
    
    static let testWebhook = "https://open.feishu.cn/open-apis/bot/v2/hook/993294fd-10b1-4385-8a37-053ac5f7bc67"
    
    var sendToLark: Bool {

        get async throws { try await self.sendToLark(with: Self.testWebhook) }
    }
}
