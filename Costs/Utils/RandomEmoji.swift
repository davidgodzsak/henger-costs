struct Emoji {
    private static let dictionary: [EmojiType: String] = [
        EmojiType.angry: "😡🤯😤😒😩🥴😠",
        EmojiType.artist: "🧑‍🎨🧑‍🔧🧑‍🏭",
        EmojiType.christmas: "🎅🏻🤶🏻🎄☃️",
        EmojiType.happy: "🥰☺️🥳🤗😊😌🌞🍦🍬🎉💙🖤",
        EmojiType.hello: "🙌💄🍀🌷🌹🌸💐✨🌈🍎🥦🍉🍒🍌🍓",
        EmojiType.sad: "😱😰😭😢☹️😟😔🥺🤦‍♂️🤦‍♀️🤷‍♂️🤷‍♀️"
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
