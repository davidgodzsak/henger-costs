import SwiftUI

struct Button<Label> : View where Label : View {
    var label: Label
    var width: CGFloat
    var height: CGFloat
    var onTap: () -> Void
    
    init(text: String, onTap: @escaping () -> Void) {
        self.label = Text(text) as! Label
        self.width = .infinity
        self.height = .infinity
        self.onTap = onTap
    }
    
    var body: some View {
        SwiftUI.Button(action: onTap, label: {label})
            .frame(width: width, height: height)
            .background(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.black, lineWidth: 2))
            .onTapGesture(perform: onTap)
    }
}

struct Button_Previews: PreviewProvider {
    
    static var previews: some View {
        Button<Text>(text: "Hello") {
            print("ok")
        }
    }
}
