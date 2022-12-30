import SwiftUI

struct CeramicClass: Identifiable, Hashable {
    var id: String {
        return date.description + String(numberOfPeople) + String(timeInHours)
    }

    let date: Date
    let numberOfPeople: Int
    let timeInHours: Int
    
    init(_ date: Date, _ numberOfPeople: Int, _ timeInHours: Int) {
        self.date = date
        self.numberOfPeople = numberOfPeople
        self.timeInHours = timeInHours
    }
}

extension CeramicClass {
    static let sampleData = [
        CeramicClass(Date(), 1, 2),
        CeramicClass(Date(), 2, 2),
        CeramicClass(Date(), 2, 2),
        CeramicClass(Date(), 1, 2)
    ]
}
