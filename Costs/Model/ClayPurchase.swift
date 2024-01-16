import Foundation
import RealmSwift


class ClayPurchaseDetail: PurchaseDetail {
    @Persisted var clay: Clay?
    @Persisted var amountInKg: Int = 0
}

class Clay: EmbeddedObject {
    @Persisted var name: String = ""
    @Persisted var pricePerKg: Double = 0
    @Persisted var bagWeight: Int = 0
    
    override var description: String { name }
}

// TODO: SHOULD COME FROM SETTINGS
extension Clay {
    static var WM = Clay(value: ["name": "WM", "bagWeight": 10, "pricePerKg": 365])
    static var WM2502 = Clay(value: ["name": "WM 2502 (10 kg)", "bagWeight": 10, "pricePerKg": 365])
    static var Nigra2002 = Clay(value: ["name": "Nigra 2002", "bagWeight": 10, "pricePerKg": 365])
//    static var WMS2502 = Clay(value: ["name": "WMS 2502", "packageWeight": 10, "color": "white + pirit", "maxTempInC": 1260, "pricePerKg": 365])
//    static var Betongrau = Clay(value: ["name": "Betongrau", "packageWeight": 10, "color": "gray", "maxTempInC": 1260, "pricePerKg": 365])
//    static var SG = Clay(value: ["name": "SG", "packageWeight": 10, "color": "white", "maxTempInC": 1150, "pricePerKg": 365])
}

extension ClayPurchaseDetail {
    func calculatePrice(prices: Prices) -> Int {
        let price: Double = prices.clayPrices.first { $0.name == self.clay!.name }?.pricePerKg ?? 0
        return Int(round(price * Double(self.amountInKg)))
    }
}

extension Purchase {
    static var sampleClayPurchases = [
        ClayPurchaseDetail(value: [ "clay": Clay.WM2502, "amountInKg": 10]),
        ClayPurchaseDetail(value: [ "clay": Clay.WM, "amountInKg": 10]),
        ClayPurchaseDetail(value: [ "clay": Clay.Nigra2002, "amountInKg": 10])
    ].map{ Purchase(value: ["detail": $0, "price": ($0 as ClayPurchaseDetail).calculatePrice(prices: Prices()) ]) }
}

