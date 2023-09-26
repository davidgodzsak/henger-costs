import SwiftUI
import WrappingHStack
import BottomSheet
import RealmSwift

enum FormInputField {
    case Size
    case Count
}

struct FiringDetailView: View {
    let firing: Firing
    
    @Environment(\.presentationMode) var mode
    @ObservedResults(Firing.self) var firings : Results<Firing>

    @ObservedResults(
        Prices.self,
        sortDescriptor: SortDescriptor(keyPath: "_id", ascending: false)
    ) var prices : Results<Prices>
    
    private var latestPrices: Prices { prices.first! }

    // TODO: use viewmodel
    @State private var size: String = ""
    @State private var count: String = "1"
    @State private var selectedFiring: FireType = FireType.BisqueAndHigh
    @State private var usedGlaze: String = "nem használtam"
    
    // bottom sheet
    @State private var sizeBottomSheetPosition: BottomSheetPosition = .hidden
    @State private var countBottomSheetPosition: BottomSheetPosition = .hidden
    @FocusState private var focusedField: FormInputField?
    
    var body: some View {
        Form {
            SizeAndCountSection
            FireTypeSection
            GlazeSection
        }
        .onChange(of: focusedField, perform: showKeyboard)
        .numberBottomSheet(position: $sizeBottomSheetPosition, value: $size, header: "Méret")
        .numberBottomSheet(position: $countBottomSheetPosition, value: $count, header: "Darab", allowDecimal: false)
        .navigationTitle("🔥 Égetés hozzáadása")
    }
    
    // TODO: SPLIT TO FILES
    private var SizeAndCountSection : some View {
        Section(header: Text("Méretek és darabszám").font(.jbBody)) {
            VStack {
                VStack {
                    if firing.items.count > 0 {
                        WrappingHStack(firing.items, id: \.self, spacing: .constant(8), lineSpacing:8) { option in
                            HStack {
                                Text(option.description)
                                Button(action: {
                                    if let at = firing.items.firstIndex(where: { $0 == option }) {
                                        firing.items.remove(at: at)
                                    }
                                }, label: {
                                    Image(systemName: "xmark").font(.system(size: 20))
                                })
                                .padding(8)
                            }
                            .padding(.leading, 12.0)
                            .buttonStyle(font: .jbBodyLarge)
                        }
                    } else {
                        Text("Addj hozzá égetést...")
                            .foregroundColor(Color.gray)
                            .font(.jbBody)
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(16)
                .frame(maxWidth: .infinity, minHeight: 100)
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.1)))
                .onTapGesture{ focusedField = .Size }
                
                HStack(alignment: VerticalAlignment.bottom ,spacing: 32) {
                    VStack(alignment: HorizontalAlignment.leading) {
                        Text("Méret").font(.jbBodyLarge)
                        
                        TextField("cm", text: $size)
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.black, lineWidth: 2))
                            .task {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    focusedField = .Size
                                }
                            }
                            .focused($focusedField, equals: .Size)
                            .onTapGesture{ focusedField = .Size }
                    }
                    
                    VStack(alignment: HorizontalAlignment.leading) {
                        Text("Darab").font(.jbBodyLarge)
                       
                        TextField("db", text: $count)
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.black, lineWidth: 2))
                            .focused($focusedField, equals: .Count)
                            .onTapGesture{
                                count = ""
                                focusedField = .Count
                            }
                    }
                    
                    Button("Hozzáadás") {
                        let toDouble = size.replacingOccurrences(of: ",", with: ".")
                        let item = FiredItem()
                        item.size = Double(toDouble) ?? 0
                        item.amount = Int(count) ?? 1
                        firing.items.append(item)
                        
                        size = ""
                        count = "1"
                    }
                        .padding(.vertical, 16).padding(.horizontal, 32)
                        .buttonStyle()
                        .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
        .padding(16)
    }
    
    private var FireTypeSection: some View {
        Section(header: Text("Égetés fajtája").font(.jbBody)) {
            HStack {
                ButtonMultiSelect<FireType>(
                    // TODO: Firetype.values
                    options: [
                        FireType.BisqueAndHigh,
                        FireType.BisqueAndLow,
                        FireType.BisqueOnly,
                        FireType.HighOnly,
                        FireType.LowOnly
                    ],
                    selected: $selectedFiring
                )
            }.padding(16)
        }
    }
    
    private var GlazeSection : some View {
        Section(
            header: Text("Henger máz").font(.jbBody),
            footer: HStack {
                Spacer()
                Button("Hozzáadás") {
                    firing.fireType = selectedFiring
                    firing.wasGlazed = usedGlaze == "használtam"
                    firing.price = firing.priceForFirings(settings: latestPrices)
                    
                    // TODO: HANDLE ERROR
                    $firings.append(firing)
                    
                    mode.wrappedValue.dismiss()
                }
                    .padding(.vertical, 16).padding(.horizontal, 32)
                    .buttonStyle(font: .jbBodyLarge)
                    .padding(.vertical, 16)
            }
        ) {
            HStack {
                ButtonMultiSelect<String>(
                    // TODO: USE TUPLE text to boolean
                    options: ["használtam", "nem használtam"],
                    selected: $usedGlaze
                )
            }
            .padding(16)
        }
    }
    
    private func showKeyboard(field: FormInputField?) {
           self.hideKeyboard()
           if(field == .Count) {
               countBottomSheetPosition = .middle
               sizeBottomSheetPosition = .hidden
           } else if (field == .Size) {
               countBottomSheetPosition = .hidden
               sizeBottomSheetPosition = .middle
           }
    }
}

struct FiringDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FiringDetailView(firing: Firing())
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
