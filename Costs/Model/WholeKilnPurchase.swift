import Foundation
import RealmSwift


class WholeKilnDetail: PurchaseDetail {
    @Persisted var fireType: FireType = FireType.BisqueAndHigh
    @Persisted var kilnId: Kilns = Kilns.Borisz
}

extension WholeKilnDetail {
    func calculatePriceForKiln(prices: Prices) -> Int  {
        let kilnPrices =  prices.kilnPrices.first{$0.kilnId == self.kilnId}
        
        if kilnPrices == nil {
            print("AJJJAJJJJJJ")
//            throw RuntimeError("KilnId not found!")
            fatalError("No kiln prices set!")
        }
        
        switch fireType {
        case .HighOnly:
            return kilnPrices!.high
        case .LowOnly:
            return kilnPrices!.low
        case .BisqueOnly:
            return kilnPrices!.bisque
        case .BisqueAndHigh:
            return kilnPrices!.high + kilnPrices!.bisque
        case .BisqueAndLow:
            return kilnPrices!.low + kilnPrices!.bisque
        }
    }
}

// TODO: GET FROM DB!!!
enum Kilns : String, CustomStringConvertible, Hashable, PersistableEnum {
    case Borisz, Priszcilla
    
    var description: String {
        switch self {
        case .Borisz:
            return "kiskemi"
        case .Priszcilla:
            return "nagykemi"
        }
    }
}


extension Purchase {
    static let sampleWholeKilns: [Purchase] = [
        Purchase(value:
                    [
                        "detail": WholeKilnDetail(value:[
                                        "fireType": FireType.BisqueAndLow,
                                        "kilnId": Kilns.Borisz
                                    ]),
                    
                    "price": 4325
                    ]
                )

    ]
}
