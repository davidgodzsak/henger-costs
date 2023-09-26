import SwiftUI
import RealmSwift

struct ClassDetailView: View {
    let ceramicClass: CeramicClass
    
    @Environment(\.presentationMode) var mode
    @ObservedResults(CeramicClass.self) var classes : Results<CeramicClass>
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
                        ceramicClass.numberOfPeople = people
                        ceramicClass.timeInHours = time
                        ceramicClass.price =  people * time * latestPrices.ceramicClassPricePerHour
                        
                        // TODO: HANDLE ERROR
                        $classes.append(ceramicClass)
                        
                        mode.wrappedValue.dismiss()
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
            .padding(16)
        } .navigationTitle("⏰ Óra hozzáadása")
    }
}

struct AddClassView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClassDetailView(ceramicClass: CeramicClass.sampleData[0])
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
