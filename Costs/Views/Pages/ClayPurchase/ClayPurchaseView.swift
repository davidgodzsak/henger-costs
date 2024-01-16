import SwiftUI

struct ClayPurchaseView: View {
    let clayPurchases: [Purchase]
    private let dateFormatter = DateFormatter();
    
    @EnvironmentObject var userHandler: UserHandler
    @Environment(\.realm) var realm
    
    init(clayPurchases: [Purchase]) {
        self.clayPurchases = clayPurchases
        dateFormatter.dateFormat = "YYYY.MM.dd"
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 40) {
            Table(
                data: clayPurchases,
                columns: [
                    TableColumn("Dátum", width: 180){ Text(dateFormatter.string(from: $0.date))},
                    TableColumn("Agyag"){ Text(($0.detail?.getValue(realm: realm) as? ClayPurchaseDetail)?.clay!.name ?? "")},
                    TableColumn("Menyiség", width: 100, alignment: .trailing){ Text("\(($0.detail?.getValue(realm: realm) as? ClayPurchaseDetail)?.amountInKg ?? 0) kg")},
                    TableColumn("Ár", width: 150, alignment: .trailing){ Text("\($0.price) Ft")}
                ],
                deleteCoversion: onDelete
            )
            
            NavigationLink(
                destination: ClayPurchaseDetailView(
                    clayPurchase: Purchase(value: ["userId": userHandler.loggedInUser?._id])
                )
            ) {
                Text("Hozzáadás")
                    .padding(.vertical, 18)
                    .padding(.horizontal, 24)
                    .buttonStyle(font: .jbBodyLarge)
            }
            Spacer()
        }
        .padding(16)
        .frame(maxHeight: .infinity)
        .navigationTitle(Text("🍶 Agyagaid"))
    }
    
    private func onDelete(_ indexSet: IndexSet) {
        let selectedPurchases = indexSet.map { clayPurchases[$0]._id }
        realm.objects(Purchase.self)
            .filter { selectedPurchases.contains($0._id) }
            .forEach { purchase in
                try! realm.write {
                    purchase.markedDeleted = true
                }
            }
    }
}

struct Clay_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClayPurchaseView(clayPurchases: Purchase.sampleClayPurchases)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
