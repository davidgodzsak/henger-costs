import SwiftUI

struct Firing: Hashable, Identifiable {
    let id = UUID()
    let date: Date
    let fireType: FireType
    let wasGlazed: Bool
    let items: [FiredItem]
    let price: Int
}

struct FiredItem: Hashable, CustomStringConvertible {
    let size: Float
    let amount: Int
    
    var description: String {
        return amount > 1 ? "\(size)cm x \(amount)db" : "\(size)cm"
    }
}

enum FireType : CustomStringConvertible {
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

extension Firing {
    static let sampleData: [Firing] = [
        Firing(
            date: Date(),
            fireType: FireType.BisqueAndLow,
            wasGlazed: false,
            items: [FiredItem(size: 23, amount: 1),FiredItem(size: 10, amount: 5), FiredItem(size: 12, amount: 1), FiredItem(size: 15, amount: 2), FiredItem(size: 10, amount: 3), FiredItem(size: 8, amount: 3)],
            price: 4325
        )
    ]
}
