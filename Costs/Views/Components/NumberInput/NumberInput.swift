
import SwiftUI

struct NumberInput: View {
    private static let RemoveChar: Character = "x"
    
    @Binding var value: String
    
    var allowDecimal: Bool = false;
    
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
                if(allowDecimal) {
                    NumberInputButton(",", tapped)
                }
                NumberInputButton("0", tapped)
                NumberInputButton(displayed: "<-", value: NumberInput.RemoveChar, tapped)
            }
        }
        .padding(.bottom, 64).padding(.top,  32.0)
    }
    
    private func tapped(_ input: Character) {
        switch input {
        case NumberInput.RemoveChar:
            if(!value.isEmpty) { value.removeLast() }
        default:
            value.append(input)
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
    @State var input = ""
    
    static var previews: some View {
        NumberInputTest()
    }
}
