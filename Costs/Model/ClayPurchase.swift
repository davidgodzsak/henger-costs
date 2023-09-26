import Foundation
import RealmSwift

class ClayPurchase: Object, ObjectKeyIdentifiable, Purchase {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var date: Date = Date()
    @Persisted var clay: Clay?
    @Persisted var amountInKg: Int = 0
    
    @Persisted var userId: ObjectId
    @Persisted var price: Int = 0
    @Persisted var isBilled: Bool = false
    @Persisted var markedDeleted: Bool = false
}

class Clay: EmbeddedObject {
    @Persisted var name: String = ""
    @Persisted var pricePerKg: Double = 0
    @Persisted var bagWeight: Int = 0
    
    override var description: String { name }
}

extension Clay {
    static var WM = Clay(value: ["name": "WM", "bagWeight": 10, "pricePerKg": 365])
    static var WM2502 = Clay(value: ["name": "WM 2502 (10 kg)", "bagWeight": 10, "pricePerKg": 365])
    static var Nigra2002 = Clay(value: ["name": "Nigra 2002", "bagWeight": 10, "pricePerKg": 365])
//    static var WMS2502 = Clay(value: ["name": "WMS 2502", "packageWeight": 10, "color": "white + pirit", "maxTempInC": 1260, "pricePerKg": 365])
//    static var Betongrau = Clay(value: ["name": "Betongrau", "packageWeight": 10, "color": "gray", "maxTempInC": 1260, "pricePerKg": 365])
//    static var SG = Clay(value: ["name": "SG", "packageWeight": 10, "color": "white", "maxTempInC": 1150, "pricePerKg": 365])
}

extension ClayPurchase {
    static var sampleData = [
        ClayPurchase(value: ["userId": ObjectId.generate(), "clay": Clay.WM2502, "amountInKg": 10, "price": 3650]),
        ClayPurchase(value: ["userId": ObjectId.generate(), "clay": Clay.WM, "amountInKg": 10, "price": 3650]),
        ClayPurchase(value: ["userId": ObjectId.generate(), "clay": Clay.Nigra2002, "amountInKg": 10, "price": 3650, "markedDeleted": true])
    ]
}
