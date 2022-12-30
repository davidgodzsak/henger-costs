import SwiftUI

struct ClayPurchase: Identifiable, Hashable {
    let id: String
    let date: Date;
    let clay: Clay;
    let amount: Int;
    let price: Int;
}

extension ClayPurchase {
    static let sampleData: [ClayPurchase] = [
        ClayPurchase(id: "wm2502_10_2022-01-01", date: Date(), clay: Clay.WM2502, amount: 10, price: 5480),
        ClayPurchase(id: "wms2502_10_2022-01-01", date: Date(), clay: Clay.WMS2502, amount: 10, price: 2480),
        ClayPurchase(id: "nigra_10_2022-01-01", date: Date(), clay: Clay.Nigra2002, amount: 10, price: 4480),
        ClayPurchase(id: "betongrau_10_2022-01-01", date: Date(), clay: Clay.Betongrau, amount: 10, price: 5480),
        ClayPurchase(id: "nigra_10_2022-01-01", date: Date(), clay: Clay.Nigra2002, amount: 10, price: 5480)
    ]
}
