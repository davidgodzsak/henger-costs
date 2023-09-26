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
        realmUser = try await app.login(credentials: Credentials.anonymous)

        configuration = realmUser?.flexibleSyncConfiguration(initialSubscriptions: { subs in
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
        
        // firings
        try await subs.update {
            if let userFiring = subs.first(named: "user_firings") {
                userFiring.updateQuery(toType: Firing.self){
                    $0.userId == user._id
                }
            } else {
                subs.append(QuerySubscription<Firing>(name: "user_firings") {
                    $0.userId == user._id
                })
            }
        }
        
        // classes
        try await subs.update {
            if let userClasses = subs.first(named: "user_classes") {
                userClasses.updateQuery(toType: CeramicClass.self){
                    $0.userId == user._id
                }
            } else {
                subs.append(QuerySubscription<CeramicClass>(name: "user_classes") {
                    $0.userId == user._id
                })
            }
        }
        
        // clay
        try await subs.update {
            if let userClayPurchase = subs.first(named: "user_clay_purchases") {
                userClayPurchase.updateQuery(toType: ClayPurchase.self){
                    $0.userId == user._id
                }
            } else {
                subs.append(QuerySubscription<ClayPurchase>(name: "user_clay_purchases") {
                    $0.userId == user._id
                })
            }
        }
    }
}
    
