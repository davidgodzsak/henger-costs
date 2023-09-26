import SwiftUI
import RealmSwift
import Foundation

struct ClayPurchaseDetailView: View {
    let clayPurchase: ClayPurchase
    
    @Environment(\.presentationMode) var mode
    @ObservedResults(ClayPurchase.self) var purchases : Results<ClayPurchase>
    @ObservedResults(
        Prices.self,
        sortDescriptor: SortDescriptor(keyPath: "_id", ascending: false)
    ) var prices : Results<Prices>
    
    private var latestPrices: Prices { prices.first! }
    
    @State private var selectedClay: Clay = Clay.WM
    @State private var packages: Int = 1;
    @State private var name: String  = "";
    @State var text: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Agyag fajtája").font(.jbBody)) {
                ButtonMultiSelect<Clay>(
                    options: Array(latestPrices.clayPrices),
                    selected: $selectedClay
                )
            }.padding(16)
            
            
            Section(
                header: Text("Menyiség").font(.jbBody),
                footer: HStack {
                    Spacer()
                    Button("Hozzáadás"){
                        clayPurchase.amountInKg = packages * selectedClay.bagWeight
                        clayPurchase.clay = Clay(value: selectedClay)
                        clayPurchase.price =  Int(round(Double(packages * selectedClay.bagWeight) * selectedClay.pricePerKg))
                        
                        // TODO: HANDLE ERROR
                        $purchases.append(clayPurchase)
                        
                        mode.wrappedValue.dismiss()
                    }
                        .padding(.vertical, 16).padding(.horizontal, 32)
                        .buttonStyle(font: .jbBodyLarge)
                        .padding(.vertical, 16)
                }
            ) {
                HStack {
                    Spacer()
                    Stepper(value: $packages, in: 1...5) {
                        Text("\(packages * selectedClay.bagWeight) kg").font(.jbBodyLarge)
                    }
                    .padding(16)
                    .frame(width:250)
                }
            }
        }
        .navigationTitle("🍶 Agyag hozzáadása")
    }
}

struct AddClayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClayPurchaseDetailView(clayPurchase: ClayPurchase())
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
