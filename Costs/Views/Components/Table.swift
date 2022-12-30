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
    
    init(data: [T], columns: [TableColumn<T, Text>]) {
        self.data = data
        self.columns = columns
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

            ForEach(0..<data.count) { i in
                let date = data[i]
                HStack {
                    ForEach(columns, id: \.name) { column in
                        column.mapper(date)
                            .font(Font.jbBody)
                            .frame(maxWidth: column.width, alignment: column.alignment)
                    }
                }
                .padding(8)
                .frame(maxWidth: .infinity)
                .background( i % 2 == 1 ? Color.black.opacity(0.1) : Color.white.opacity(0))
            }
        }
    }
}


struct Table_Previews: PreviewProvider {
    static var previews: some View {
        Table(
            data: ClayPurchase.sampleData,
            columns: [
                TableColumn("Name"){ n in Text(n.clay.name)},
                TableColumn("Amount"){ n in Text(String(n.amount))},
                TableColumn("Price", alignment: .trailing){ n in Text(String(n.price))}
            ])
    }
}
