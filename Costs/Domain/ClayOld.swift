import SwiftUI

struct ClayOld: Hashable, CustomStringConvertible {
    let name: String
    let packageWeight: Int
    let color: String
    let grogSize: GrogSize
    var temperatureRange: ClosedRange<Int> = 1200...1260
    
    var description: String { return name }
}

enum GrogSize {
    case Fine
    case Medium
    case Large
}

extension ClayOld {
    static var WM2502 = ClayOld(name: "WM 2502 (10 kg)", packageWeight: 10, color: "white", grogSize: GrogSize.Fine)
//    static WM2502_20 = Clay(name: "WM 2502 (20 kg)", packageWeight: 20, color: "white", grogSize: GrogSize.Fine)
    static var WMS2502 = ClayOld(name: "WMS 2502", packageWeight: 10, color: "white", grogSize: GrogSize.Fine)
    static var Nigra2002 = ClayOld(name: "Nigra 2002", packageWeight: 10, color: "black", grogSize: GrogSize.Medium, temperatureRange: 1200...1220)
    static var Betongrau = ClayOld(name: "Betongrau", packageWeight: 10, color: "black", grogSize: GrogSize.Medium)
    static var SG = ClayOld(name: "Betongrau", packageWeight: 10, color: "black", grogSize: GrogSize.Medium, temperatureRange: 1050...1150)
}
