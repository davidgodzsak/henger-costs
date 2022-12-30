import SwiftUI

struct ClayView: View {
    let clayPurchases: [ClayPurchase]
    private let dateFormatter = DateFormatter();
    
    init(clayPurchases: [ClayPurchase]) {
        self.clayPurchases = clayPurchases
        dateFormatter.dateFormat = "YYYY.MM.dd"
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 40) {
            Table(
                data: clayPurchases,
                columns: [
                    TableColumn("Dátum", width: 180){ Text(dateFormatter.string(from: $0.date))},
                    TableColumn("Agyag"){ Text($0.clay.name)},
                    TableColumn("Menyiség", width: 100, alignment: .trailing){ Text("\($0.amount) kg")},
                    TableColumn("Ár", width: 150, alignment: .trailing){ Text("\($0.price) Ft")}
                ]
            )
            
            NavigationLink(destination: AddClayView()) {
                Text("+ Hozzáadás")
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
}

struct Clay_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClayView(clayPurchases: ClayPurchase.sampleData)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
