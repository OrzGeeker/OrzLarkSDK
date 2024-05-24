# OrzLarkSDK

Lark SDK write by swift programming language


## Feature

- send message to Lark Group with a webhook which fetched from the custom bot that been added into Lark Group

- [support message type][message type]:
    
    - text
    
    - post
    
    - image
    
    - share_chat
    
    - interactive


[message type]: <https://open.feishu.cn/document/client-docs/bot-v3/add-custom-bot#%E6%94%AF%E6%8C%81%E5%8F%91%E9%80%81%E7%9A%84%E6%B6%88%E6%81%AF%E7%B1%BB%E5%9E%8B%E8%AF%B4%E6%98%8E>

## Usage with Swift Package Manager

- add dependency

```swift
.package(url: "https://github.com/OrzGeeker/OrzLarkSDK.git", branch: "main")
```

- use the product on your target dependency

```swift
.product(name: "Message", package: "OrzLarkSDK")
```

- Construct a message and send it to the Lark Group with webhook url. The Lark Group should have a custom bot joined, so you can get the webhook url

```swift
import Message

try await Message.make.text("text message content").sendToLark(with: "<your_lark_group_custom_bot_webhook_url>")
```

- send other type message can reference: [unit tests](https://github.com/OrzGeeker/OrzLarkSDK/blob/main/Tests/MessageTests/MessageTests.swift)
