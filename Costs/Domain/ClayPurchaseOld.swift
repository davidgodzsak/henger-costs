import SwiftUI

struct ClayPurchaseOld: Identifiable, Hashable {
    let id: String
    let date: Date;
    let clay: ClayOld;
    let amount: Int;
    let price: Int;
}

extension ClayPurchaseOld {
    static let sampleData: [ClayPurchaseOld] = [
        ClayPurchaseOld(id: "wm2502_10_2022-01-01", date: Date(), clay: ClayOld.WM2502, amount: 10, price: 5480),
        ClayPurchaseOld(id: "wms2502_10_2022-01-01", date: Date(), clay: ClayOld.WMS2502, amount: 10, price: 2480),
        ClayPurchaseOld(id: "nigra_10_2022-01-01", date: Date(), clay: ClayOld.Nigra2002, amount: 10, price: 4480),
        ClayPurchaseOld(id: "betongrau_10_2022-01-01", date: Date(), clay: ClayOld.Betongrau, amount: 10, price: 5480),
        ClayPurchaseOld(id: "nigra_10_2022-01-01", date: Date(), clay: ClayOld.Nigra2002, amount: 10, price: 5480)
    ]
}
