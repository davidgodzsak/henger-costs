import SwiftUI
import RealmSwift
import Foundation

struct MenuView: View {
    let user: User
    @EnvironmentObject var userHandler: UserHandler
    
    @ObservedResults(
        Firing.self,
        where: {$0.isBilled == false},
        sortDescriptor: SortDescriptor(keyPath: "date")
    ) var firings: Results<Firing>
    
    @ObservedResults(
        CeramicClass.self,
        where: {$0.isBilled == false},
        sortDescriptor: SortDescriptor(keyPath: "date")
    )
    var classes: Results<CeramicClass>
    
    @ObservedResults(
        ClayPurchase.self,
        where: {$0.isBilled == false},
        sortDescriptor: SortDescriptor(keyPath: "date")
    ) var clayPurchases: Results<ClayPurchase>
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        HStack {
            VStack(spacing: 64) {
                MainMenu
                LogoutButton
            }
            .padding(16)
        }
        .navigationTitle("Szia \(user.name) \(Emoji.random(.hello, .happy))")
        .navigationBarBackButtonHidden(true)
    }
    
    private var MainMenu: some View {
        return VStack(spacing: 16) {
            NavigationLink(destination: FiringView(firings: Array(firings))) {
                Text("🔥 Égetés").menu()
            }
            NavigationLink(destination: ClayPurchaseView(clayPurchases: Array(clayPurchases))) {
                Text("🍶 Agyag").menu()
            }
            NavigationLink(destination: ClassesView(classes: Array(classes))) {
                Text("⏰ Óra").menu()
            }
        }
    }
    
    private var LogoutButton: some View {
        return Text("🚪 Kilépés").menu(color: .red)
            .frame(height: 80)
            .onTapGesture {
                userHandler.logOut()
            }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MenuView(user: User.sampleData[0])
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
