import SwiftUI

struct ClassesView: View {
    let classes: [CeramicClass]
    
    @EnvironmentObject var userHandler: UserHandler
    @Environment(\.realm) var realm
    private let dateFormatter = DateFormatter()
    
    init(classes: [CeramicClass]) {
        self.classes = classes  
        dateFormatter.dateFormat = "YYYY.MM.dd"
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 40) {
            Table(
                data: classes,
                columns: [
                    TableColumn("Dátum"){ Text(dateFormatter.string(from: $0.date))},
                    TableColumn("Fő"){ Text(String($0.numberOfPeople))},
                    TableColumn("Időtartam", alignment: .trailing){ Text("\($0.timeInHours) h")}
                ],
                deleteCoversion: onDelete
            )

            NavigationLink(
                destination: ClassDetailView(
                    ceramicClass: CeramicClass(value: ["userId": userHandler.loggedInUser!._id])
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
        .navigationTitle("⏰ Óráid")
    }
    
    private func onDelete(_ indexSet: IndexSet) {
        let selectedClasses = indexSet.map { classes[$0]._id }
        realm.objects(CeramicClass.self)
            .filter { selectedClasses.contains($0._id) }
            .forEach { ceramicClass in
                 try! realm.write {
                     ceramicClass.markedDeleted = true
                }
            }
    }
}

struct Classes_Previews: PreviewProvider {
    static var previews: some View {
        ClassesView(classes: CeramicClass.sampleData)
    }
}
