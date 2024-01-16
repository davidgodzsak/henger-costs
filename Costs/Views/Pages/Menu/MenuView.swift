import SwiftUI
import RealmSwift
import Foundation

struct MenuView: View {
    let user: User
    @EnvironmentObject var userHandler: UserHandler
    
    @ObservedResults(
        Purchase.self,
        where: {$0.isBilled == false && $0.detail.typeName == "FiringPurchaseDetail"},
        sortDescriptor: SortDescriptor(keyPath: "date")
    ) var firings: Results<Purchase>
    
    @ObservedResults(
        Purchase.self,
        where: {$0.isBilled == false && $0.detail.typeName == "WholeKilnDetail"},
        sortDescriptor: SortDescriptor(keyPath: "date")
    ) var kilns: Results<Purchase>
    
    @ObservedResults(
        Purchase.self,
        where: {$0.isBilled == false && $0.detail.typeName == "PrivateClassDetail"},
        sortDescriptor: SortDescriptor(keyPath: "date")
    )
    var classes: Results<Purchase>
    
    @ObservedResults(
        Purchase.self,
        where: {$0.isBilled == false && $0.detail.typeName == "WorkshopPurchaseDetail"},
        sortDescriptor: SortDescriptor(keyPath: "date")
    )
    var workshops: Results<Purchase>
    
    @ObservedResults(
        Purchase.self,
        where: {$0.isBilled == false && $0.detail.typeName == "ClayPurchaseDetail"},
        sortDescriptor: SortDescriptor(keyPath: "date")
    ) var clayPurchases: Results<Purchase>
    
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
            NavigationLink(destination: FiringView(firings: Array(firings), kilns: Array(kilns))) { //todo remove Array
                Text("🔥 Égetés").menu()
            }
            NavigationLink(destination: ClayPurchaseView(clayPurchases: Array(clayPurchases))) {
                Text("🍶 Agyag").menu()
            }
            NavigationLink(destination: ClassesView(classes: Array(classes))) {
                Text("📓 Oktatás").menu()
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
