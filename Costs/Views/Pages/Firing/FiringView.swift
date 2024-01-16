import SwiftUI
import RealmSwift

struct FiringView: View {
    let firings: [Purchase]
    let kilns: [Purchase]
    private let dateFormatter = DateFormatter()
    
    @EnvironmentObject var userHandler: UserHandler
    @State private var isWholeKiln = false

    @Environment(\.realm) var realm

    init(firings: [Purchase], kilns: [Purchase]) {
        self.firings = firings
        self.kilns = kilns
        dateFormatter.dateFormat = "YYYY.MM.dd"
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: 40) {
            if isWholeKiln {
                KilnTable
                
                NavigationLink(
                    destination: FiringWholeKilnView(wholeKiln: Purchase(value: ["userId": userHandler.loggedInUser!._id]))
                ) {
                    Text("Hozzáadás")
                        .padding(.vertical, 18)
                        .padding(.horizontal, 24)
                        .buttonStyle(font: .jbBodyLarge)
                }
                Spacer()
            } else {
                FiringTable
                
                NavigationLink(
                    destination: FiringSinglePieceView(firing: Purchase(value: ["userId": userHandler.loggedInUser?._id]))
                ) {
                    Text("Hozzáadás")
                        .padding(.vertical, 18)
                        .padding(.horizontal, 24)
                        .buttonStyle(font: .jbBodyLarge)
                }
                Spacer()
            }
        }
        .padding(16)
        .frame(maxHeight: .infinity)
        .navigationTitle(Text("🔥 Égetéseid"))
        .safeAreaInset(edge: .top) {
                HStack {
                    Spacer()
                    Picker("Égetés fajtája?", selection: $isWholeKiln) {
                        Text("Darabonként").tag(false)
                        Text("Teljes kemi").tag(true)
                    }
                    .pickerStyle(.segmented)
                    .padding(16)
                    Spacer()
                }
        }
    }
    
    var KilnTable: some View {
        Table(
            data: kilns,
            columns: [
                TableColumn("Dátum", width: 110){
                    Text(dateFormatter.string(from: $0.date))
                },
                TableColumn("Kemi", width: 100, alignment: .trailing){ Text(($0.detail?.getValue(realm: realm) as? WholeKilnDetail)?.kilnId.description ?? Kilns.Borisz.description )},
                TableColumn("Égetés", width: 100, alignment: .trailing){ Text(($0.detail?.getValue(realm: realm) as? WholeKilnDetail)?.fireType.description ?? FireType.HighOnly.description )},
                TableColumn("Ár", width: 120, alignment: .trailing){ Text("\($0.price) Ft")}
            ],
            deleteCoversion: onDeleteKiln // TODO: https://www.mongodb.com/docs/realm/sdk/swift/swiftui/pass-realm-data-between-views/#pass-realm-objects-to-a-view
        )
    }
    
    var FiringTable: some View {
        Table(
            data: firings,
            columns: [
                TableColumn("Dátum", width: 110){
                    Text(dateFormatter.string(from: $0.date))
                },
                TableColumn("Méretek"){ Text(verbatim: ($0.detail?.getValue(realm: realm) as? FiringPurchaseDetail)?.items.map { "\($0.description)"}.joined(separator: ", ") ?? "")},
                TableColumn("Égetés", width: 100, alignment: .trailing){ Text(($0.detail?.getValue(realm: realm) as? FiringPurchaseDetail)?.fireType.description ?? "") },
                TableColumn("Máz", width: 70, alignment: .trailing){ Text(($0.detail?.getValue(realm: realm) as? FiringPurchaseDetail)?.wasGlazed ?? false ? "van" : "nincs") },
                TableColumn("Ár", width: 120, alignment: .trailing){ Text("\($0.price) Ft")}
            ],
            deleteCoversion: onDeleteFire
        )
    }
    
    private func onDeleteFire(_ indexSet: IndexSet) {
        let selectedFirings = indexSet.map { firings[$0]._id }
        realm.objects(Purchase.self)
            .filter { selectedFirings.contains($0._id) }
            .forEach { firing in
                 try! realm.write {
                    firing.markedDeleted = true
                }
            }
    }
    
    private func onDeleteKiln(_ indexSet: IndexSet) {
        let selectedKilns = indexSet.map { kilns[$0]._id }
        realm.objects(Purchase.self)
            .filter { selectedKilns.contains($0._id) }
            .forEach { kiln in
                 try! realm.write {
                    kiln.markedDeleted = true
                }
            }
    }
}

struct Firing_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FiringView(firings: Purchase.sampleFirings, kilns: Purchase.sampleWholeKilns)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
