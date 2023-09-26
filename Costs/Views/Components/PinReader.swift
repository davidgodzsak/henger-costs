import SwiftUI
import BottomSheet

struct PinReader: View {
    @Binding var user: User
    var evaluateLogin: (String) -> LogInResult

    @State var pin: String = ""
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                ForEach(0..<user.pin.count, id: \.self) { index in
                    if digitAt(index) != nil {
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
        }
        .bottomSheet(
            bottomSheetPosition: $bottomSheetPosition,
            options: [
                .shadow(color: .black.opacity(0.3), radius: 32, x: 0, y: 0),
                .cornerRadius(64),
                .notResizeable,
                .noDragIndicator
            ]) {
                NumberInput(value: $pin, maxDigits: 4, onMaxReached: {
                    let result = evaluateLogin(pin)
                    
                    if(result == LogInResult.Error) {
                        pin=""
                    }
                })
                    .padding(.bottom, 64).padding(.top,  32.0)
            }
            .navigationTitle("\(user.name) Pin")
    }
    
    // TODO: Refactor this is ugly
    private func digitAt(_ index: Int) -> String? {
        let pin = Array(self.pin)
        
        if pin.indices.contains(index), !String(pin[index]).isEmpty {
            return String(pin[index])
        }
        
        return nil
    }
}

struct PinReaderTest : View {
    @State var user = User(value: ["_id": "123", "name":"David", "pin": "1234", "active": true])
    
    var body: some View {
        VStack {
            PinReader(user: $user, evaluateLogin: {p in
                return LogInResult.Success
            })
        }
    }
}

struct PinStackView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PinReaderTest()
        }.navigationViewStyle(.stack)
    }
}
