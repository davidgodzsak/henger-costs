import SwiftUI


extension View {
    public func buttonStyle(color: Color = .black, font: Font = .jbBodyLarge) -> some View {
        self
            .foregroundColor(color)
            .background(RoundedRectangle(cornerRadius: 16).style(withStroke: color, lineWidth: 2, fill: Color.white))
            .font(font)
    }
    
    public func numberButton(color: Color = .black) -> some View {
        self
            .padding()
            .foregroundColor(color)
            .frame(width: 64, height: 64, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Circle().strokeBorder(color, lineWidth: 1))
            .font(.jbNumberInput)
    }
    
    public func menu(color: Color = .black) -> some View {
        return self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .buttonStyle(color: color, font: .jbSubTitle)
    }
}

struct ButtonTypes_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLink(destination: FiringView(firings: Purchase.sampleFirings, kilns: []), label: { Text("🔥 Égetés").menu() })
    }
}
