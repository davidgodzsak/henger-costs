import SwiftUI
import RealmSwift


struct FiringWholeKilnView : View {
    let wholeKiln: Purchase
    
    @Environment(\.presentationMode) var mode
    @Environment(\.realm) var realm

    @ObservedResults(
        Prices.self,
        sortDescriptor: SortDescriptor(keyPath: "_id", ascending: false)
    ) var prices : Results<Prices>
    
    private var latestPrices: Prices { prices.first! }
    
    @State private var selectedFiring: FireType = FireType.HighOnly
    @State private var selectedKiln: Kilns = Kilns.Borisz


    var body: some View {
        Form {
            FireTypeSection(combined: false, selectedFiring: $selectedFiring)
            
            Section(header: Text("Kemi").font(.jbBody)) {
                HStack {
                    ButtonMultiSelect<Kilns>(
                        options: [Kilns.Borisz, Kilns.Priszcilla],
                        selected: $selectedKiln
                    )
                }.padding(16)
            }
        }
            
            Button("Hozzáadás") {
                let detail = WholeKilnDetail()
                detail.fireType = selectedFiring
                detail.kilnId = selectedKiln
                wholeKiln.price = detail.calculatePriceForKiln(prices: latestPrices)
                wholeKiln.detail = AnyPurchaseDetail(detail)
                
                // TODO: HANDLE ERROR
                try! realm.write {
                    realm.add(detail)
                    realm.add(wholeKiln)
                    mode.wrappedValue.dismiss()
                }
            }
                .padding(.vertical, 16).padding(.horizontal, 32)
                .buttonStyle()
                .buttonStyle(BorderlessButtonStyle())
    }
}
