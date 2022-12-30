//
//  NumberInputButton.swift
//  Costs
//
//  Created by Dávid Godzsák on 12/12/2022.
//

import SwiftUI

struct NumberInputButton : View {
    private let displayed: String
    private let value: Character?
    private let action: (Character) -> Void
    
    init(_ displayed: String, _ action: @escaping (Character) -> Void) {
        self.displayed = displayed
        self.value = nil
        self.action = action
    }
    
    init(displayed: String, value: Character? = nil, _ action: @escaping (Character) -> Void) {
        self.displayed = displayed
        self.value = value
        self.action = action
    }
    
    var body: some View {
        Button(action: {action(value ?? displayed.first!)}) {
            Text(String(displayed)).numberButton()
        }
    }
}

struct NumberInputButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NumberInputButton("<-", {_ in})
            NumberInputButton("1", {_ in})
            NumberInputButton("C", {_ in})
        }
    }
}
