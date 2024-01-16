import SwiftUI

func FireTypeSection(combined: Bool, selectedFiring: Binding<FireType>) -> some View {
    let combinedOptions = [
        FireType.BisqueAndHigh,
        FireType.BisqueAndLow,
        FireType.BisqueOnly,
        FireType.HighOnly,
        FireType.LowOnly
    ]
    
    let normalOptions = [
        FireType.BisqueOnly,
        FireType.HighOnly,
        FireType.LowOnly
    ]
    
    return Section(header: Text("Égetés fajtája").font(.jbBody)) {
        HStack {
            ButtonMultiSelect<FireType>(
                // TODO: Firetype.values
                options: combined ? combinedOptions : normalOptions,
                selected: selectedFiring
            )
        }.padding(16)
    }
}
