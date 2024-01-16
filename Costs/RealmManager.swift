import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private let realmConfig: RealmConfig

    @Published var realmUser: RealmSwift.User?
    @Published var configuration: Realm.Configuration?
    let app: App
    
    init(_ realmConfig: RealmConfig) {
        self.realmConfig = realmConfig
        self.app = RealmSwift.App(id: realmConfig.appId)
    }
    
    @MainActor
    func configure() async throws {
        app.syncManager.errorHandler = { error, session in
            guard let syncError = error as? SyncError else {
                fatalError("Unexpected error type passed to sync error handler! \(error)")
            }
            switch syncError.code {
            case .clientResetError:
                if let (path, clientResetToken) = syncError.clientResetInfo() {
                    print(path)
                    SyncSession.immediatelyHandleError(clientResetToken, syncManager: self.app.syncManager)
                }
            default:
                // Handle other errors...
                ()
            }
        }
        
        realmUser = try await app.login(credentials: Credentials.anonymous)

        configuration = realmUser?.flexibleSyncConfiguration( initialSubscriptions: { subs in
            if let _ = subs.first(named: "users") {
               return
            } else {
                subs.append(QuerySubscription<User>(name: "users"))
            }

            if let _ = subs.first(named: "settings") {
               return
            } else {
                subs.append(QuerySubscription<Prices>(name: "settings"))
            }
        }, rerunOnOpen: true)
//
//        // TODO: HANDLE ASYNC PROBLEMS https://www.mongodb.com/docs/atlas/app-services/sync/error-handling/client-resets/
//        // TODO: ERROR HANDLING
    }
    
    @MainActor
    func addForUser(_ user: User, realm: Realm) async throws {
        // TODO: ERROR HANDLING
        let subs = realm.subscriptions
        
        // purchase
        try await subs.update {
            if let userPurchase = subs.first(named: "user_purchases") {
                userPurchase.updateQuery(toType: Purchase.self){
                    $0.userId == user._id && $0.isBilled == false
                }
            } else {
                subs.append(QuerySubscription<Purchase>(name: "user_purchases") {
                    $0.userId == user._id && $0.isBilled == false
                })
            }
        }
        
        // TODO: NOT GOOD LOADS DATA OF ALL USERS... MAYBE USE EMBEDDED OBJECT FOR DETAIL
        try await subs.update {
            if let userClayPurchase = subs.first(named: "any_purchase_details") {
                userClayPurchase.updateQuery(toType: AnyPurchaseDetail.self)
            } else {
                subs.append(QuerySubscription<AnyPurchaseDetail>(name: "any_purchase_details"))
            }
        }

        // firings & kilns
        try await subs.update {
            if let wholeKilns = subs.first(named: "kiln_purchase_details") {
                wholeKilns.updateQuery(toType: WholeKilnDetail.self)
            } else {
                subs.append(QuerySubscription<WholeKilnDetail>(name: "kiln_purchase_details"))
            }
        }
        
        try await subs.update {
            if let wholeKilns = subs.first(named: "firing_purchase_details") {
                wholeKilns.updateQuery(toType: FiringPurchaseDetail.self)
            } else {
                subs.append(QuerySubscription<FiringPurchaseDetail>(name: "firing_purchase_details"))
            }
        }
        
        // classes & workshops
        try await subs.update {
            if let userClasses = subs.first(named: "class_purchase_details") {
                userClasses.updateQuery(toType: PrivateClassDetail.self)
            } else {
                subs.append(QuerySubscription<PrivateClassDetail>(name: "class_purchase_details"))
            }
        }
        
        try await subs.update {
            if let workshops = subs.first(named: "workshop_purchase_details") {
                workshops.updateQuery(toType: WorkshopPurchaseDetail.self)
            } else {
                subs.append(QuerySubscription<WorkshopPurchaseDetail>(name: "workshop_purchase_details"))
            }
        }
        
        // clay
        try await subs.update {
            if let userClayPurchase = subs.first(named: "clay_purchase_details") {
                userClayPurchase.updateQuery(toType: ClayPurchaseDetail.self)
            } else {
                subs.append(QuerySubscription<ClayPurchaseDetail>(name: "clay_purchase_details"))
            }
        }
    }
}
    
