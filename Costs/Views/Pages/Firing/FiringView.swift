import SwiftUI

struct FiringView: View {
    let firings: [Firing]
    private let dateFormatter = DateFormatter();
    
    init(firings: [Firing]) {
        self.firings = firings
        dateFormatter.dateFormat = "YYYY.MM.dd"
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: 40) {
            Table(
                data: Firing.sampleData,
                columns: [
                    TableColumn("Dátum", width: 110){
                        Text(dateFormatter.string(from: $0.date))
                    },
                    TableColumn("Méretek"){ Text(verbatim: $0.items.map { "\($0.description)"}.joined(separator: ", "))},
                    TableColumn("Égetés", width: 100, alignment: .trailing){ Text($0.fireType.description) },
                    TableColumn("Máz", width: 70, alignment: .trailing){ Text($0.wasGlazed ? "van" : "nincs") },
                    TableColumn("Ár", width: 120, alignment: .trailing){ Text("\($0.price) Ft")}
                ]
            )
            
            NavigationLink(destination: FiringDetailView()) {
                Text("+ Hozzáadás")
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
}

struct Firing_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FiringView(firings: Firing.sampleData)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
