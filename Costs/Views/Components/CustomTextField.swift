import SwiftUI
import BottomSheet

struct CustomTextField<Keyboard: View>: View {
    let placeholder: String
    @Binding var isFocused: Bool
    @Binding var value: String
    @ViewBuilder let keyboard: (Binding<String>) -> Keyboard
    
    @State private var bottomSheetPosition: BottomSheetPosition = .middle
    @State private var cursorBlink = 0.0
    
    private var cursor: some View {
        Text("|")
            .opacity(cursorBlink)
            .animation(.easeInOut(duration: 0.6).repeatForever(), value: cursorBlink)
            .onAppear { cursorBlink =  1.0}
    }
    
    private var contentDependentTextField: some View {
        HStack(alignment: VerticalAlignment.top, spacing: 4) {
            if value.isEmpty {
                if isFocused {
                    cursor
                } else {
                    Text(placeholder).foregroundColor(.gray)
                }
            } else {
                if isFocused {
                    Text(value)
                    cursor
                } else {
                    Text(value)
                }
            }
            Spacer()
        }
    }
    
    var body: some View {
        contentDependentTextField
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.black, lineWidth: 2))
    }
}

struct TextFieldWithKeyboard_Test: View {
    @State var value1: String = "asd"
    @State var value2: String = ""
    @State var focused = true
    @State var unFocused = false
    
    var body: some View {
        VStack {
            CustomTextField<NumberInput>(placeholder: "Placeholder", isFocused: $unFocused, value: $value2) { val in
                NumberInput(value: val)
            }
            CustomTextField<NumberInput>(placeholder: "Placeholder", isFocused: $focused, value: $value2) { val in
                NumberInput(value: val)
            }
            CustomTextField<NumberInput>(placeholder: "Placeholder", isFocused: $focused, value: $value1) { val in
                NumberInput(value: val)
            }
            CustomTextField<NumberInput>(placeholder: "Placeholder", isFocused: $unFocused, value: $value1) { val in
                NumberInput(value: val)
            }
        }
    }
}

struct TextFieldWithKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithKeyboard_Test()
    }
}
