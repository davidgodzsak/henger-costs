import SwiftUI

struct UserOld : Identifiable {
    let id: String
    let name: String
    let pin: String
}

extension UserOld {
    static let sampleData: [UserOld] = [
        UserOld(id: UUID().uuidString, name: "Debóra",pin: "1234"),
        UserOld(id: UUID().uuidString, name: "Ildikó",pin: "3561"),
        UserOld(id: UUID().uuidString, name: "Luca",pin: "3918"),
        UserOld(id: UUID().uuidString, name: "Márti",pin: "9128"),
        UserOld(id: UUID().uuidString, name: "Lucia",pin: "9183"),
        UserOld(id: UUID().uuidString, name: "Boglárka",pin: "2221"),
        UserOld(id: UUID().uuidString, name: "Réka",pin: "9191"),
        UserOld(id: UUID().uuidString, name: "Vanda",pin: "3192"),
        UserOld(id: UUID().uuidString, name: "Flóra",pin: "2322"),
    ]
}
