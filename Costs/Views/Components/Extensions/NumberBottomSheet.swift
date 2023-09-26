import BottomSheet
import SwiftUI

extension View {
    
    func numberBottomSheet<Content: View>(
        position: Binding<BottomSheetPosition>,
        value: Binding<String>,
        @ViewBuilder headerContent: @escaping () -> Content? = { return nil },
        allowDecimal: Bool = true
    ) -> some View {
        self
            .bottomSheet(
                bottomSheetPosition: position,
                options: [
                    .shadow(color: .black.opacity(0.3), radius: 32, x: 0, y: 0),
                    .cornerRadius(64),
                    .notResizeable,
                    .tapToDismiss,
                    .noDragIndicator
                ]
            ) {
                headerContent()
                
                NumberInput(value: value, allowDecimal: allowDecimal).padding(.bottom, 64)
            }
    }
    
    func numberBottomSheet(
        position: Binding<BottomSheetPosition>,
        value: Binding<String>,
        header: String? = nil,
        allowDecimal: Bool = true
    ) -> some View {
        self
            .numberBottomSheet(
                position: position,
                value: value,
                headerContent: {
                    if header != nil {
                        Text(header!).font(.jbNumberInput).padding(8)
                    }
                },
                allowDecimal: allowDecimal
            )
    }
}
