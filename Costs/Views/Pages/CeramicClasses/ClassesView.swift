import SwiftUI

struct ClassesView: View {
    let classes: [Purchase]
    let workshops: [Purchase]
    
    @State private var isWorkshop = false
    
    @EnvironmentObject var userHandler: UserHandler
    @Environment(\.realm) var realm
    private let dateFormatter = DateFormatter()
    
    init(classes: [Purchase] = [], workshops: [Purchase] = []) {
        self.classes = classes
        self.workshops = workshops
        dateFormatter.dateFormat = "YYYY.MM.dd"
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 40) {
            if isWorkshop {
                WorkshopsTable
                
                NavigationLink(
                    destination: WorkshopDetailView(workshop: Purchase(value: ["userId": userHandler.loggedInUser?._id]))
                ) {
                    Text("Hozzáadás")
                        .padding(.vertical, 18)
                        .padding(.horizontal, 24)
                        .buttonStyle(font: .jbBodyLarge)
                }
                Spacer()
            } else {
                PrivateClassTable
                
                NavigationLink(
                    destination: PrivateClassDetailView(privateClass: Purchase(value: ["userId": userHandler.loggedInUser?._id]))
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
        .navigationTitle(Text("📓 Oktatások"))
        .safeAreaInset(edge: .top) {
                HStack {
                    Spacer()
                    Picker("Oktatás típúsa?", selection: $isWorkshop) {
                        Text("Egyéni óra").tag(false)
                        Text("Workshop").tag(true)
                    }
                    .pickerStyle(.segmented)
                    .padding(16)
                    Spacer()
                }
        }
    }
    
    var PrivateClassTable: some View {
        VStack(alignment: .trailing, spacing: 40) {
            Table(
                data: classes,
                columns: [
                    TableColumn("Dátum"){ Text(dateFormatter.string(from: $0.date))},
                    TableColumn("Fő"){ Text(String(($0.detail?.getValue(realm: realm) as? PrivateClassDetail)?.numberOfPeople ?? 0))},
                    TableColumn("Időtartam", alignment: .trailing){ Text("\(($0.detail?.getValue(realm: realm) as? PrivateClassDetail)?.timeInHours ?? 0) h")},
                    TableColumn("Ár", alignment: .trailing){ Text("\($0.price) Ft")}
                ],
                deleteCoversion: onDeleteClass
            )
        }
    }
    
    var WorkshopsTable: some View {
        VStack(alignment: .trailing, spacing: 40) {
            Table(
                data: workshops,
                columns: [
                    TableColumn("Dátum"){ Text(dateFormatter.string(from: $0.date))},
                    TableColumn("Fő"){ Text(String(($0.detail?.getValue(realm: realm) as? WorkshopPurchaseDetail)?.numberOfPeople ?? 0))},
                    TableColumn("Workshop díja", alignment: .trailing){ Text("\(($0.detail?.getValue(realm: realm) as? WorkshopPurchaseDetail)?.priceOfWorkshop ?? 0) Ft")},
                    TableColumn("Ár", alignment: .trailing){ Text("\($0.price) Ft")}
                ],
                deleteCoversion: onDeleteWorkshop
            )
        }
    }
    
    private func onDeleteClass(_ indexSet: IndexSet) {
        let selectedClasses = indexSet.map { classes[$0]._id }
        realm.objects(Purchase.self)
            .filter { selectedClasses.contains($0._id) }
            .forEach { ceramicClass in
                 try! realm.write {
                     ceramicClass.markedDeleted = true
                }
            }
    }
    
    private func onDeleteWorkshop(_ indexSet: IndexSet) {
        let selectedWorkshops = indexSet.map { workshops[$0]._id }
        realm.objects(Purchase.self)
            .filter { selectedWorkshops.contains($0._id) }
            .forEach { workshop in
                 try! realm.write {
                     workshop.markedDeleted = true
                }
            }
    }
}

struct Classes_Previews: PreviewProvider {
    static var previews: some View {
        ClassesView(classes: Purchase.samplePrivateClasses)
    }
}
