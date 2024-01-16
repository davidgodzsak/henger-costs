import RealmSwift
import Foundation

// TODO: FROM DB
private let PERCENTAGE = 0.2

class WorkshopPurchaseDetail: PurchaseDetail {
    @Persisted var priceOfWorkshop: Int
    @Persisted var numberOfPeople: Int
}

extension WorkshopPurchaseDetail {
    func calculatePriceForWorkshop(prices: Prices) -> Int {
        return Int(round(Double(priceOfWorkshop * numberOfPeople) * PERCENTAGE))
    }
}
