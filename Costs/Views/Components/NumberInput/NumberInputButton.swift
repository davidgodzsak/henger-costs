import SwiftUI
import AVFoundation

struct NumberInputButton : View {
    private let displayed: String?
    private let image: Image?
    private let value: Character?
    private let action: (Character) -> Void
    
    init(_ displayed: String, _ action: @escaping (Character) -> Void) {
        self.displayed = displayed
        self.value = nil
        self.image = nil
        self.action = action
    }
    
    init(displayed: String, value: Character? = nil, _ action: @escaping (Character) -> Void) {
        self.displayed = displayed
        self.value = value
        self.action = action
        self.image = nil
    }
    
    init(image: Image, value: Character, _ action: @escaping (Character) -> Void) {
        self.image = image
        self.value = value
        self.action = action
        self.displayed = nil
    }
    
    var body: some View {
        Button(
            action: {
                action(value ?? displayed!.first!)
                AudioServicesPlaySystemSoundWithCompletion(1104) {}
            }
        ) {
            if displayed != nil {
                Text(displayed!).numberButton()
                
            } else {
                image?.numberButton()
            }
        }
    }
}

struct NumberInputButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NumberInputButton("<-", {_ in})
            NumberInputButton("1", {_ in})
            NumberInputButton("C", {_ in})
            NumberInputButton(image: Image(systemName: "delete.left"), value:  "x", {_ in})
        }
    }
}
