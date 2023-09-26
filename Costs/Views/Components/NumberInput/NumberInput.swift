import AVFoundation
import SwiftUI

struct NumberInput: View {
    private static let RemoveChar: Character = "x"
    
    @Binding var value: String
    
    var allowDecimal: Bool = false;
    
    // TODO: Should not be here probably
    var maxDigits: Int = Int.max
    
    // TODO: Should not be here probably
    var onMaxReached: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 16) {
            HStack(spacing: 16) {
                NumberInputButton("1", tapped)
                NumberInputButton("2", tapped)
                NumberInputButton("3", tapped)
            }
            HStack(spacing: 16) {
                NumberInputButton("4", tapped)
                NumberInputButton("5", tapped)
                NumberInputButton("6", tapped)
            }
            HStack(spacing: 16) {
                NumberInputButton("7", tapped)
                NumberInputButton("8", tapped)
                NumberInputButton("9", tapped)
            }
            HStack(spacing: 16){
                if(allowDecimal && !value.contains(",")) {
                    NumberInputButton(",", tapped)
                }
                NumberInputButton("0", tapped)
                Button(action: {
                    tapped(NumberInput.RemoveChar)
                    AudioServicesPlaySystemSoundWithCompletion(4095) {}
                }, label: {
                    Image(systemName: "delete.left")
                        .foregroundColor(Color.black)
                        .frame(width: 64, height: 64)
                        .font(Font.custom(Font.fontName(weight: .thin), size: 36))
                })
            }
        }
    }
    
    // TODO: This logic should not be here
    private func tapped(_ input: Character) {
        switch input {
        case NumberInput.RemoveChar:
            if(!value.isEmpty) { value.removeLast() }
        default:
            if(value.count < maxDigits ) {
                value.append(input)

                if(value.count == maxDigits) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        onMaxReached()
                    }
                }
            }
        }
    }
}

private struct NumberInputTest: View {
    @State var input = ""
    
    var body: some View {
        NumberInput(value: $input, allowDecimal: false)
    }
}

struct NumberInput_Previews: PreviewProvider {
    static var previews: some View {
        NumberInputTest()
    }
}

private struct NumberInputTest2: View {
    @State var input = ""
    
    var body: some View {
        VStack {
            Text(input)
            NumberInput(value: $input, allowDecimal: true, maxDigits: 4, onMaxReached: {
                input = "";
            })
        }
    }
}


struct NumberInput_Preview2: PreviewProvider {
    static var previews: some View {
        NumberInputTest2()
    }
}
