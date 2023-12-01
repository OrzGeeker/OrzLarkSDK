//
//  Message+Creator.swift
//
//
//  Created by joker on 2023/12/1.
//

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
