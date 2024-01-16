//
//  Table.swift
//  Costs
//
//  Created by Dávid Godzsák on 13/12/2022.
//

import SwiftUI

struct TableColumn<T, U: View> where T : Identifiable {
    let name: String
    let mapper: (T) -> U
    let width: CGFloat
    let alignment: Alignment
    
    init(_ name : String, width: CGFloat = .infinity, alignment: Alignment = .leading, @ViewBuilder _ mapper: @escaping (T) -> U) {
        self.name = name
        self.mapper = mapper
        self.width = width
        self.alignment = alignment
    }
}

struct Table<T>: View where T : Identifiable {
    let data: [T]
    let columns: [TableColumn<T, Text>]
    let deleteCoversion: (IndexSet) -> Void
    
    init(
        data: [T],
        columns: [TableColumn<T, Text>],
        deleteCoversion: @escaping (IndexSet) -> Void
    ) {
        self.data = data
        self.columns = columns
        self.deleteCoversion = deleteCoversion
    }
    
    var body: some View {
        VStack(spacing:0) {
            HStack {
                ForEach(columns, id: \.name) { column in
                    Text(column.name)
                        .font(Font.jbBody.bold())
                        .frame(maxWidth: column.width, alignment: column.alignment)
                }
            }
            .padding(8)
            .frame(maxWidth: .infinity)
            
            Divider()
                .frame(height: 2)
                .background(Color.black)
            
            List {
                ForEach(0..<data.count, id: \.self) { i in
                    row(data, i)
                        .listRowBackground(
                            i % 2 == 1 ? Color.black.opacity(0.1) : Color.white.opacity(0)
                        )
                        .listRowInsets(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                        .listRowSeparator(.hidden)
                }
                .onDelete(perform: deleteCoversion)
            }
            .listStyle(.plain)
        }
    }
    
    func row(_ data: [T], _ i: Int) -> some View {
        ZStack {
            let date = data[i]
            
            
                if date is Purchase && (date as! Purchase).markedDeleted {
                    Rectangle().frame(maxWidth: .infinity, maxHeight: 1, alignment: .center)
                }
            HStack {
                ForEach(columns, id: \.name) { column in
                    column.mapper(date)
                        .font(Font.jbBody)
                        .frame(maxWidth: column.width, alignment: column.alignment)
                }
            }
        }
    }
}


struct Table_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Table(
                data: Purchase.sampleClayPurchases,
                columns: [
                    TableColumn("Name"){ n in Text("WM")},
                    TableColumn("Amount"){ n in Text("20 kg")},
                    TableColumn("Price", alignment: .trailing){ n in Text(String(123))}
                ]
            ) { indexSet in }
        }
        .navigationViewStyle(.stack)
    }
}
