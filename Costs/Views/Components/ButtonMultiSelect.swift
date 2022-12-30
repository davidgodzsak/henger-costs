import SwiftUI
import WrappingHStack

struct ButtonMultiSelect<T>: View where T: CustomStringConvertible, T: Hashable {
    var options: [T]
    @Binding var selected: T
    
    var body: some View {
        WrappingHStack(options, id: \.self, spacing: .constant(16), lineSpacing:16) { option in
            BadgeButton(text: option.description, isActive: $selected.map {sel in sel == option}) {
                selected = option
            }
        }
    }
}

struct ButtonMultiSelect_Test: View {
    @State private var selected: String = "Second"
    
    var body: some View {
        ButtonMultiSelect<String>(options: ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh"], selected: $selected)
    }
}

struct ButtonMultiSelect_Previews: PreviewProvider {
    static var previews: some View {
        ButtonMultiSelect_Test()
    }
}
