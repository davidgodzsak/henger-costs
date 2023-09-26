import SwiftUI
import RealmSwift

struct ContentView: View {
    @EnvironmentObject var realmManager: RealmManager
    @EnvironmentObject var userHandler: UserHandler
    @Environment(\.realm) var realm
    
    let pub = NotificationCenter.default
            .publisher(for: UIApplication.didEnterBackgroundNotification)
    
    @ObservedResults(
        User.self,
        where: {$0.active == true},
        sortDescriptor: SortDescriptor(keyPath: "_id", ascending: true)
    ) var activeUsers: Results<User>
    
    var body: some View {
        NavigationView{
            if userHandler.isLoggedIn {
                MenuView(user: userHandler.loggedInUser!)
                    .task {
                        // TODO: HANDLE ERROR
                        try? await realmManager.addForUser(userHandler.loggedInUser!, realm: realm)
                    }
            } else {
                LoginView(users: Array(activeUsers))
            }
        }
        .onReceive(pub) { notification in
            userHandler.logOut()
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserHandler())
    }
}
