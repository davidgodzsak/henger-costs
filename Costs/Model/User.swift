import RealmSwift
import Foundation

class User: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var active: Bool = false
    @Persisted var comments: List<String>
    @Persisted var days: List<String>
    @Persisted var email: String = ""
    @Persisted var groups: List<String>
    @Persisted var hashedPassword: String?
    @Persisted var monthlyFee: Int = 0
    @Persisted var name: String = ""
    @Persisted var otp: String?
    @Persisted var pin: String = ""
    @Persisted var startedAt: String = ""
}

extension User {
    static let sampleData = [
        User(value: ["_id": ObjectId.generate(), "name":"David", "pin": "1234", "active": true]),
        User(value: ["_id": ObjectId.generate(), "name":"Debóra", "pin": "1234", "active": true])
    ]
}
