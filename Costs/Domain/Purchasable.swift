import Foundation

protocol Purchasable: Deletable {
    associatedtype Id
    associatedtype Payload
    
    var price: Int { get set }
    var isBilled: Bool { get set }
    var date: Date { get set }
    var markedDeleted: Bool { get set }
    var userId: Id { get set }
    var payload: Payload? { get set }
}

