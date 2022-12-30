import SwiftUI

struct AddClayView: View {
    @State private var selectedClay: Clay = Clay.Betongrau
    @State private var packages: Int = 1;
    @State private var name: String  = "";
    @State var text: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Agyag fajtája").font(.jbBody)) {
                ButtonMultiSelect<Clay>(
                    options: [
                        Clay.SG,
                        Clay.Nigra2002,
                        Clay.WM2502,
                        Clay.Betongrau,
                        Clay.WMS2502
                    ],
                    selected: $selectedClay
                )
            }.padding(16)
            
            Section(
                header: Text("Menyiség").font(.jbBody),
                footer: HStack {
                    Spacer()
                    Button("Hozzáadás"){}
                        .padding(.vertical, 16).padding(.horizontal, 32)
                        .buttonStyle(font: .jbBodyLarge)
                        .padding(.vertical, 16)
                }
            ) {
                HStack {
                    Spacer()
                    Stepper(value: $packages, in: 1...5) {
                        Text("\(packages*selectedClay.packageWeight) kg").font(.jbBodyLarge)
                    }
                    
                    .frame(width:200)
                }
            }
        }
        .navigationTitle("🍶 Agyag hozzáadása")
    }
}

struct AddClayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddClayView()
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
