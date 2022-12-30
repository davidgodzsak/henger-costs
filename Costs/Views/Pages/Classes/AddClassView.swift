//
//  AddClassView.swift
//  Costs
//
//  Created by Dávid Godzsák on 24/12/2022.
//

import SwiftUI

struct AddClassView: View {
    @State private var people: Int = 1;
    @State private var time: Int = 1;
    
    var body: some View {
        Form {
            Section(
                header: Text("Óra").font(.jbBody),
                footer: HStack {
                    Spacer()
                    Button("Óra hozzáadása"){}
                        .padding(.vertical, 16).padding(.horizontal, 32)
                        .buttonStyle(font: .jbBodyLarge)
                        .padding(.vertical, 16)
                }
            ) {
                VStack {
                    HStack(alignment: VerticalAlignment.bottom ,spacing: 32) {
                        VStack(alignment: HorizontalAlignment.leading) {
                            Text("Fő").font(.jbBodyLarge)
                            TextField("Ember", text: $people.map{it in "\(it)"})
                                .padding(16)
                                .background(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.black, lineWidth: 2))
                                .font(.jbBody)
                        }
                        
                        VStack(alignment: HorizontalAlignment.leading) {
                            Text("Időtartam").font(.jbBodyLarge)
                            TextField("Óra", text: $time.map{it in "\(it)"})
                                .padding(16)
                                .background(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.black, lineWidth: 2))
                                .font(.jbBody)
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
            AddClassView()
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
