import SwiftUI
import RealmSwift

struct PrivateClassDetailView: View {
    let privateClass: Purchase
    
    @Environment(\.presentationMode) var mode
    
    @Environment(\.realm) var realm
    @ObservedResults(
        Prices.self,
        sortDescriptor: SortDescriptor(keyPath: "_id", ascending: false)
    ) var prices : Results<Prices>
    
    private var latestPrices: Prices { prices.first! }
    
    @State private var people: Int = 1;
    @State private var time: Int = 1;
    
    var body: some View {
        Form {
            Section(
                header: Text("Óra").font(.jbBody),
                footer: HStack {
                    Spacer()
                    Button("Hozzáadás"){
                        // TODO: DOES NOT WORK WITH EDIT
                        let detail = PrivateClassDetail()
                        detail.numberOfPeople = people
                        detail.timeInHours = time
                        privateClass.detail = AnyPurchaseDetail(detail)
                        privateClass.price =  people * time * latestPrices.ceramicClassPricePerHour
                        
                        // TODO: HANDLE ERROR
                        try! realm.write {
                            realm.add(detail)
                            realm.add(privateClass)
                            
                            mode.wrappedValue.dismiss()
                        }
                    }
                        .padding(.vertical, 16).padding(.horizontal, 32)
                        .buttonStyle(font: .jbBodyLarge)
                        .padding(.vertical, 16)
                }
            ) {
                VStack {
                    // TODO: MAYBE NOT BEST UI
                    HStack(alignment: VerticalAlignment.bottom ,spacing: 32) {
                        VStack(alignment: HorizontalAlignment.leading) {
                            Text("Fő").font(.jbBodyLarge)
                            Stepper(value: $people, in: 1...15) {
                                Text("\(people) fő").font(.jbBodyLarge)
                            }
                            .padding(16)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.03)))
                        }
                        
                        VStack(alignment: HorizontalAlignment.leading) {
                            Text("Időtartam").font(.jbBodyLarge)
                            Stepper(value: $time, in: 1...5) {
                                Text("\(time) h").font(.jbBodyLarge)
                            }
                            .padding(16)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.03)))
                        }
                    }
                }
            }
        }
    }
    
}

struct PrivateClassDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrivateClassDetailView(privateClass: Purchase.samplePrivateClasses.first!)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

