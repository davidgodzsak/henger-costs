import SwiftUI

struct MenuView: View {
    let user: User
    
    var body: some View {
        HStack {
            VStack(spacing: 64) {
                addMainMenu()
                addLogoutButton()
            }
            .padding(16)
        }
        .navigationTitle("Szia \(user.name) \(Emoji.random(.hello, .happy))")
        .navigationBarBackButtonHidden(true)
    }
    
    private func addMainMenu() -> some View {
        return VStack(spacing: 16) {
            NavigationLink(destination: FiringView(firings: Firing.sampleData)) {
                Text("🔥 Égetés").menu()
            }
            NavigationLink(destination: ClayView(clayPurchases: ClayPurchase.sampleData)) {
                Text("🍶 Agyag").menu()
            }
            NavigationLink(destination: ClassesView(classes: CeramicClass.sampleData)) {
                Text("⏰ Óra").menu()
            }
        }
    }
    
    private func addLogoutButton() -> some View {
        return Text("🚪 Kilépés").menu(color: .red)
            .frame(height: 80)
            .onTapGesture {
                
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
