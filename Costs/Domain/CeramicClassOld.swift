import SwiftUI

struct CeramicClassOld: Identifiable, Hashable {
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

extension CeramicClassOld {
    static let sampleData = [
        CeramicClassOld(Date(), 1, 2),
        CeramicClassOld(Date(), 2, 2),
        CeramicClassOld(Date(), 2, 2),
        CeramicClassOld(Date(), 1, 2)
    ]
}
