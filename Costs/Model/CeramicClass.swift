import RealmSwift
import Foundation

class CeramicClass: Object, ObjectKeyIdentifiable, Purchase {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var numberOfPeople: Int = 0
    @Persisted var timeInHours: Int = 0
    
    @Persisted var userId: ObjectId
    @Persisted var date: Date = Date()
    @Persisted var price: Int
    @Persisted var isBilled: Bool = false
    @Persisted var markedDeleted: Bool = false
}

extension CeramicClass {
    static let sampleData = [
        CeramicClass(value: ["date": Date(), "numberOfPeople": 2, "timeInHours": 2, "price": 6000]),
        CeramicClass(value: ["date": Date(), "numberOfPeople": 3, "timeInHours": 1, "price": 4500])
    ]
}
