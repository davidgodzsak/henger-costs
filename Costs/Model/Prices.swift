import RealmSwift
import Foundation

class Prices: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var ceramicClassPricePerHour: Int = 0
    @Persisted var firingPrice: FiringPrice?
    @Persisted var glazePrice: GlazePrice?
    @Persisted var clayPrices = List<Clay>()
    @Persisted var kilnPrices = List<KilnPrices>()
}

class KilnPrices: EmbeddedObject {
    @Persisted var kilnId: Kilns
    @Persisted var bisque: Int = 0
    @Persisted var high: Int = 0
    @Persisted var low: Int = 0
}

class GlazePrice: EmbeddedObject {
    @Persisted var treshold: Int = 0
    @Persisted var belowPrice: Int = 0
    @Persisted var abovePrice: Int = 0
}

class FiringPrice: EmbeddedObject {
    @Persisted var fireTypesExponentials: List<FireTypeProperties>
    
    // TODO: UNIT TEST
    // TODO: LOGIC SHOULD NOT BELONG HERE
    func firingPriceSettingsFor(_ fireType: FireType) throws -> [ExponentialFittingProperties] {
        var toReturn: [FireType] = [];
        if(fireType == .BisqueAndLow) {
            toReturn = [.BisqueOnly, .LowOnly]
        } else if(fireType == .BisqueAndHigh) {
            toReturn = [.BisqueOnly, .HighOnly]
        } else {
            toReturn = [fireType]
        }
        
        let selected =  fireTypesExponentials
            .filter { toReturn.contains($0.fireType) }
            .map { $0.exponentialFittingProperties! }
        
        guard( selected.count == toReturn.count ) else {
            throw RuntimeError("Not all firing type prices were found in DB")
        }
        return Array(selected)
    }
}

class FireTypeProperties: EmbeddedObject {
    @Persisted var fireType: FireType = .HighOnly
    @Persisted var exponentialFittingProperties: ExponentialFittingProperties?
}

class ExponentialFittingProperties: EmbeddedObject {
    @Persisted var A: Double = 0
    @Persisted var B: Double = 0
}

struct RuntimeError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
