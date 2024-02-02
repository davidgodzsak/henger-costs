import Foundation

let TAX = 1.27

extension Int {
    func withTax() -> Int {
        return Int(round(Double(self) * TAX))
    }
}
