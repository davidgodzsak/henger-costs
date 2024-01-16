import RealmSwift
import Foundation


class FiringPurchaseDetail: PurchaseDetail {
    @Persisted var fireType: FireType = FireType.BisqueAndHigh
    @Persisted var wasGlazed: Bool = false
    @Persisted var items: List<FiredItem>
}

class FiredItem: EmbeddedObject {
    @Persisted var size: Double = 0
    @Persisted var amount: Int = 0
    
    override var description: String {
        let s = size.rounded() == size ? String(Int(size)) : String(size)
        return amount > 1 ? "\(s)cm x \(amount)db" : "\(s)cm"
    }
}

enum FireType : String, CustomStringConvertible, Hashable, PersistableEnum {
    case HighOnly
    case LowOnly
    case BisqueOnly
    case BisqueAndHigh
    case BisqueAndLow
    
    var description: String {
        switch self {
        case .HighOnly:
            return "csak magas"
        case .LowOnly:
            return "csak alacsony"
        case .BisqueOnly:
            return "csak zsenge"
        case .BisqueAndHigh:
            return "magas + zsenge"
        case .BisqueAndLow:
            return "alacsony + zsenge"
        }
    }
}

// TODO: SHIT
extension Purchase {
    static let sampleFirings: [Purchase] = [
        Purchase(
            value:
                    [
                        "detail": FiringPurchaseDetail(
                            value: [
                                "fireType": FireType.BisqueAndLow,
                                "wasGlazed": false,
                                "items": [
                                    FiredItem(value: ["size": 23, "amount": 1]),
                                    FiredItem(value: ["size": 10, "amount": 5]),
                                    FiredItem(value: ["size": 12, "amount": 1]),
                                    FiredItem(value: ["size": 15, "amount": 2]),
                                    FiredItem(value: ["size": 10, "amount": 3]),
                                    FiredItem(value: ["size": 8, "amount": 3])
                                ]
                            ]),
                        "price": 4325
                    ]
        )
    ]
}
 
extension FiringPurchaseDetail {
    func calculatePriceForFiring(prices: Prices) -> Int {
        return self.priceForFirings(prices: prices)
    }
    
    // TODO: Move out of this function to a service or util
    static func priceForFiringItem(prices: Prices, wasGlazed: Bool, fireType: FireType, item: FiredItem) -> Int {
       // should call a backend to get
       
       let glaze = prices.glazePrice!
       // TODO: Hard to read
       let glazePrice =  wasGlazed ? Double(glaze.treshold) < item.size ? glaze.belowPrice : glaze.abovePrice : 0
       
       // TODO: ERROR HANDLING
       let exponentials = try! prices.firingPrice!.firingPriceSettingsFor(fireType)
       
        let firingPrice: Double = exponentials
            .map { $0.A * exp($0.B * Double(item.size)) * item.size * Double(item.amount)}
           .reduce(0, +)
       
       return Int(round(firingPrice)) + glazePrice
    }

    // TODO: Move out of this function to a service or util
    func priceForFirings(prices: Prices) -> Int {
       return items
            .map {FiringPurchaseDetail.priceForFiringItem(prices: prices, wasGlazed: self.wasGlazed, fireType: self.fireType, item: $0)}
           .reduce(0, +)
    }
}
