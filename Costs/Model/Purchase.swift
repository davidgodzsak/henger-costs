import RealmSwift
import Foundation

protocol Purchase: Deletable {
    var price: Int { get set }
    var isBilled: Bool { get set }
    var date: Date { get set }
    var markedDeleted: Bool { get set }
    var userId: ObjectId { get set }
}
