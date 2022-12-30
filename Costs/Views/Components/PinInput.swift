import SwiftUI
import BottomSheet

struct PinReader: View {
    @Binding var user: User
    @State var inputPin = ""
    @State var showPin = true;
    
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                ForEach(0..<user.pin.count) { digit in
                    if getDigit(digit) != nil {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 24, height: 24)
                    } else {
                        Circle()
                            .strokeBorder(lineWidth: 1)
                            .frame(width: 24, height: 24)
                    }
                }
            }
            
            NavigationLink(
                destination: MenuView(user: user),
                isActive: $inputPin.map(transform: {pin in
                    return pin == user.pin
                }),
                label: {})
        }
        .bottomSheet(bottomSheetPosition: $bottomSheetPosition,
        options: [
            .shadow(color: .black.opacity(0.3), radius: 32, x: 0, y: 0),
            .cornerRadius(64),
            .notResizeable,
            .noDragIndicator
        ]){
            NumberInput(value: $inputPin)
        }
        .navigationTitle("\(user.name) Pin")
    }
    
    
    func getDigit(_ index: Int) -> String? {
        let pin = Array(self.inputPin)
        
        if pin.indices.contains(index), !String(pin[index]).isEmpty {
            return String(pin[index])
        }
        
        return nil
    }
}

struct PinReaderTest : View {
    @State var user = User.sampleData[0];
    
    var body: some View {
        PinReader(user: $user)
    }
}

struct PinStackView_Previews: PreviewProvider {
    static var previews: some View {
        PinReaderTest()
    }
}
