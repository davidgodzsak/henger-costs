import RealmSwift
import Foundation


class PrivateClassDetail: PurchaseDetail {
    @Persisted var numberOfPeople: Int = 0
    @Persisted var timeInHours: Int = 0
}

extension Purchase {
    static let samplePrivateClasses = [Purchase(value:[
                                    "detail": PrivateClassDetail(value: ["numberOfPeople": 2, "timeInHours": 2]),
                                    "price": 6000
                                    ]
                                ),
                             Purchase(value: [
                                         "detail": PrivateClassDetail(value: ["numberOfPeople": 3, "timeInHours": 1]),
                                         "price": 4500
                                         ]
                                     )
                             ]
}

extension PrivateClassDetail {
    func calculatePriceForClass(prices: Prices) -> Int {
        return prices.ceramicClassPricePerHour * numberOfPeople * timeInHours
    }
}
