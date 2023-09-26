import RealmSwift

class User: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var pin: String = "0000"
    @Persisted var active: Bool = false
    @Persisted var email: String = ""
    @Persisted var rentPrice: Int = 0
    
//    @Persisted var atStudio: [Range]
}

extension User {
    static let sampleData = [
        User(value: ["_id": ObjectId.generate(), "name":"David", "pin": "1234", "active": true]),
        User(value: ["_id": ObjectId.generate(), "name":"Debóra", "pin": "1234", "active": true])
    ]
}
