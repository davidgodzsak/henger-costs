//
//  BadgeButton.swift
//  Costs
//
//  Created by Dávid Godzsák on 23/12/2022.
//

import SwiftUI

struct BadgeButton: View {
    let text: String
    @Binding var isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(text, action: action)
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            .foregroundColor(isActive ? Color.white : Color.black)
            .background(
                RoundedRectangle(cornerRadius: 32)
                    .style(withStroke: Color.black, lineWidth: 2, fill: isActive ? Color.black : Color.white)
            )
            .font(.jbBodyLarge)
            .buttonStyle(BorderlessButtonStyle())
    }
}

private struct BadgeButton_Test: View {
    @State var isActive: Bool = true
    @State var isNotActive: Bool = false
    
    var body: some View {
        HStack {
            BadgeButton(text: "Active", isActive: $isActive){}
            BadgeButton(text: "Not Active", isActive: $isNotActive){}
                
        }
    }
}

struct BadgeButton_Previews: PreviewProvider {
    static var previews: some View {
        BadgeButton_Test()
    }
}
