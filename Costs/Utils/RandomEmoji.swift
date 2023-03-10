struct Emoji {
    private static let dictionary: [EmojiType: String] = [
        EmojiType.angry: "π‘π€―π€ππ©π₯΄π ",
        EmojiType.artist: "π§βπ¨π§βπ§π§βπ­",
        EmojiType.christmas: "ππ»π€Άπ»πβοΈ",
        EmojiType.happy: "π₯°βΊοΈπ₯³π€ππππ¦π¬πππ€",
        EmojiType.hello: "ππππ·πΉπΈπβ¨πππ₯¦ππππ",
        EmojiType.sad: "π±π°π­π’βΉοΈπππ₯Ίπ€¦ββοΈπ€¦ββοΈπ€·ββοΈπ€·ββοΈ"
    ]
    
    static func random(_ types: EmojiType...) -> String {
        let possibleItems = dictionary
            .filter {types.contains($0.key)}
            .flatMap {$0.value}
        
        return String(possibleItems.randomElement()!)
    }
}

enum EmojiType {
    case angry, artist, christmas, happy, hello, sad
}
