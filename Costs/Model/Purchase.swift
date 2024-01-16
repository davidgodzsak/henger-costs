import RealmSwift
import Foundation

class Purchase: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var price: Int
    @Persisted var isBilled: Bool
    @Persisted var date: Date
    @Persisted var markedDeleted: Bool
    @Persisted var userId: ObjectId
    @Persisted var detail: AnyPurchaseDetail?
}

class PurchaseDetail: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId = ObjectId.generate()
}

class AnyPurchaseDetail: Object  {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var typeName: String = ""

    // A list of all subclasses that this wrapper can store
    static let supportedClasses: [PurchaseDetail.Type] = [
        FiringPurchaseDetail.self,
        PrivateClassDetail.self,
        ClayPurchaseDetail.self,
        WholeKilnDetail.self,
        WorkshopPurchaseDetail.self
    ]

    // Construct the type-erased payment method from any supported subclass
    convenience init(_ purchaseDetail: PurchaseDetail) {
        self.init()
        typeName = String(describing: type(of: purchaseDetail))
        guard let primaryKeyName = type(of: purchaseDetail).sharedSchema()?.primaryKeyProperty?.name else {
            fatalError("`\(typeName)` does not define a primary key")
        }
        guard let primaryKeyValue = purchaseDetail.value(forKey: primaryKeyName) as? ObjectId else {
            fatalError("`\(typeName)`'s primary key `\(primaryKeyName)` is not a `String`")
        }
        _id = primaryKeyValue
    }

    // Dictionary to lookup subclass type from its name
    static let detailLookup: [String : PurchaseDetail.Type] = {
        var dict: [String : PurchaseDetail.Type] = [:]
        for method in supportedClasses {
            dict[String(describing: method)] = method
        }
        return dict
    }()

    // Use to access the *actual* PaymentMethod value, using `as` to upcast
    func getValue(realm: Realm) -> PurchaseDetail {
        guard let type = AnyPurchaseDetail.detailLookup[typeName] else {
            fatalError("Unknown payment method `\(typeName)`")
        }
        
        guard let value = try! realm.object(ofType: type, forPrimaryKey: _id) else {
            fatalError("`\(type)` with primary key `\(_id)` does not exist")
        }
        return value
    }
}
