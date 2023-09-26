import SwiftUI
import RealmSwift

struct FiringView: View {
    let firings: [Firing]
    private let dateFormatter = DateFormatter()
    
    @EnvironmentObject var userHandler: UserHandler
    @Environment(\.realm) var realm

    init(firings: [Firing]) {
        self.firings = firings
        dateFormatter.dateFormat = "YYYY.MM.dd"
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: 40) {
            FiringTable
            
            NavigationLink(
                destination: FiringDetailView(
                    firing: Firing(value: ["userId": userHandler.loggedInUser!._id])
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
        .navigationTitle(Text("🔥 Égetéseid"))
    }
    
    var FiringTable: some View {
        Table(
            data: firings,
            columns: [
                TableColumn("Dátum", width: 110){
                    Text(dateFormatter.string(from: $0.date))
                },
                TableColumn("Méretek"){ Text(verbatim: $0.items.map { "\($0.description)"}.joined(separator: ", "))},
                TableColumn("Égetés", width: 100, alignment: .trailing){ Text($0.fireType.description) },
                TableColumn("Máz", width: 70, alignment: .trailing){ Text($0.wasGlazed ? "van" : "nincs") },                TableColumn("Ár", width: 120, alignment: .trailing){ Text("\($0.price) Ft")}
            ],
            deleteCoversion: onDelete
        )
    }
    
    private func onEdit() {}
    
    private func onDelete(_ indexSet: IndexSet) {
        let selectedFirings = indexSet.map { firings[$0]._id }
        realm.objects(Firing.self)
            .filter { selectedFirings.contains($0._id) }
            .forEach { firing in
                 try! realm.write {
                    firing.markedDeleted = true
                }
            }
    }
}

struct Firing_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FiringView(firings: Firing.sampleData)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
