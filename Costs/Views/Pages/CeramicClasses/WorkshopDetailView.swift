import SwiftUI
import RealmSwift
import BottomSheet


private enum FocusableField {
    case price
}


struct WorkshopDetailView: View {
    let workshop: Purchase
    
    @Environment(\.presentationMode) var mode
    @Environment(\.realm) var realm
    @ObservedResults(
        Prices.self,
        sortDescriptor: SortDescriptor(keyPath: "_id", ascending: false)
    ) var prices : Results<Prices>
    
    private var latestPrices: Prices { prices.first! }
    
    @State private var people: Int = 1;
    @State private var priceOfWorkshop: String = "";
    @State private var bottomSheetPosition: BottomSheetPosition = .hidden
    @FocusState private var focusedField: FocusableField?
    
    var body: some View {
        VStack {
            Form {
                Section(
                    header: Text("Óra").font(.jbBody),
                    footer: HStack {
                        Spacer()
                        Button("Hozzáadás"){
                            // TODO: THIS DOES NOT WORK WITH EDIT
                            let detail = WorkshopPurchaseDetail()
                            detail.numberOfPeople = people
                            detail.priceOfWorkshop = Int(priceOfWorkshop)!
                            workshop.detail = AnyPurchaseDetail(detail)
                            workshop.price =  detail.calculatePriceForWorkshop(prices: latestPrices)
                            
                            // TODO: HANDLE ERROR
                            try! realm.write {
                                realm.add(detail)
                                realm.add(workshop)
                                mode.wrappedValue.dismiss()
                            }
                        }
                        .padding(.vertical, 16).padding(.horizontal, 32)
                        .buttonStyle(font: .jbBodyLarge)
                        .padding(.vertical, 16)
                    }
                ) {
                    VStack {
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
                                Text("Workshop ár / fő").font(.jbBodyLarge)
                                TextField("cm", text: $priceOfWorkshop)
                                    .frame(maxWidth: .infinity)
                                    .padding(16)
                                    .background(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.black, lineWidth: 2))
                                    .focused($focusedField, equals: .price)
                            }
                        }
                    }
                }
            }.onChange(of: focusedField, perform: calcNumberInput)
        }
        .onTapGesture{ focusedField = nil }
        .numberBottomSheet(position: $bottomSheetPosition, value: $priceOfWorkshop, header: "Workshop díja")
    }
    
    private func calcNumberInput(it: FocusableField?) {
        self.hideKeyboard()
        if it == .price {
            bottomSheetPosition = .middle
        }
    }
    
}
