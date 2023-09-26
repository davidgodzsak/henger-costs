import SwiftUI

struct FiringOld: Hashable, Identifiable {
    let id = UUID()
    let date: Date
    let fireType: FireTypeOld
    let wasGlazed: Bool
    let items: [FiredItemOld]
    let price: Int
}

struct FiredItemOld: Hashable, CustomStringConvertible {
    let size: Float
    let amount: Int
    
    var description: String {
        return amount > 1 ? "\(size)cm x \(amount)db" : "\(size)cm"
    }
}

enum FireTypeOld : CustomStringConvertible {
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

extension FiringOld {
    static let sampleData: [FiringOld] = [
        FiringOld(
            date: Date(),
            fireType: FireTypeOld.BisqueAndLow,
            wasGlazed: false,
            items: [FiredItemOld(size: 23, amount: 1),FiredItemOld(size: 10, amount: 5), FiredItemOld(size: 12, amount: 1), FiredItemOld(size: 15, amount: 2), FiredItemOld(size: 10, amount: 3), FiredItemOld(size: 8, amount: 3)],
            price: 4325
        )
    ]
}
