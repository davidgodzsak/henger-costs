//
//  DateUtil.swift
//  Costs
//
//  Created by Dávid Godzsák on 28/02/2023.
//

import Foundation


extension Date {
    func isWithinAMonth() -> Bool {
        let today = Date();
        return self >= Calendar.current.date(byAdding: .month, value: -1, to: today)!
    }
}
