import SwiftUI

struct ClassesView: View {
    let classes: [CeramicClass]
    private let dateFormatter = DateFormatter();
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 40) {
            Table(
                data: classes,
                columns: [
                    TableColumn("Dátum"){ Text(dateFormatter.string(from: $0.date))},
                    TableColumn("Fő"){ Text(String($0.numberOfPeople))},
                    TableColumn("Időtartam", alignment: .trailing){ Text("\($0.timeInHours) h")}
                ]
            )

            NavigationLink(destination: AddClassView()) {
                Text("+ Hozzáadás")
                    .padding(.vertical, 18)
                    .padding(.horizontal, 24)
                    .buttonStyle(font: .jbBodyLarge)
            }
            Spacer()
        }
        .padding(16)
        .frame(maxHeight: .infinity)
        .navigationTitle("⏰ Óráid")
    }
}

struct Classes_Previews: PreviewProvider {
    static var previews: some View {
        ClassesView(classes: CeramicClass.sampleData)
    }
}
