//
//  FiringDetailView.swift
//  Costs
//
//  Created by Dávid Godzsák on 23/12/2022.
//

import SwiftUI
import WrappingHStack

struct FiringDetailView: View {
    private var firing: Firing?
    @State private var size: String = ""
    @State private var count: String = ""
    
    @State private var selectedFiring: FireType = FireType.BisqueAndHigh
    @State private var usedGlaze: String = "nem használtam"
    @State private var addedItems: [FiredItem] = Firing.sampleData[0].items
    
    init(_ firing: Firing? = nil) {
        self.firing = firing
    }
    
    var body: some View {
        Form {
            Section(header: Text("Méretek és darabszám").font(.jbBody)) {
                VStack {
                    WrappingHStack(addedItems, id: \.self, spacing: .constant(8), lineSpacing:8) { option in
                        HStack {
                            Text(option.description)
                            Text("|")
                            Button("x") { }.padding(8)
                        }
                        .padding(.horizontal, 12)
                        .buttonStyle(font: .jbBodyLarge)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(16)
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.1)))
                    
                    HStack(alignment: VerticalAlignment.bottom ,spacing: 32) {
                        VStack(alignment: HorizontalAlignment.leading) {
                            Text("Méret").font(.jbBodyLarge)
                            
                            TextFieldWithKeyboard(keyboard: NumberKeyboard(), placeholder: "Cm", text: $size)
                                .padding(16)
                                .frame(height: 52)
                                .background(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.black, lineWidth: 2))
                                .font(.jbBody)
                        }
                        
                        VStack(alignment: HorizontalAlignment.leading) {
                            Text("Darab").font(.jbBodyLarge)
                            
                            
                            TextFieldWithKeyboard(keyboard: NumberKeyboard(), placeholder: "Darab", text: $count)
                                .padding(16)
                                .frame(height: 52)
                                .background(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.black, lineWidth: 2))
                                .font(.jbBody)
                        }
                        
                        Button("Hozzáadás") { }
                            .padding(.vertical, 16).padding(.horizontal, 32)
                            .buttonStyle()
                            .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            .padding(16)
            
            Section(header: Text("Égetés fajtája").font(.jbBody)) {
                HStack {
                    ButtonMultiSelect<FireType>(
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
            
            Section(
                header: Text("Henger máz").font(.jbBody),
                footer: HStack {
                    Spacer()
                    Button("Hozzáadás"){}
                        .padding(.vertical, 16).padding(.horizontal, 32)
                        .buttonStyle(font: .jbBodyLarge)
                        .padding(.vertical, 16)
                }
            ) {
                HStack {
                    ButtonMultiSelect<String>(
                        options: ["használtam", "nem használtam"],
                        selected: $usedGlaze
                    )
                }
                .padding(16)
            }
        }
        .navigationTitle("🔥 Égetés hozzáadása")
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct FiringDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FiringDetailView()
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
