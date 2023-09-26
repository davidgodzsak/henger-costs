import SwiftUI
import AuthenticationServices

struct LoginView: View {
    let users: [User]
    @State private var selectedUser: User?;
    @EnvironmentObject var userHandler: UserHandler
    
    init(users: [User]) {
        self.users = users;
    }
    
    var body: some View {
        VStack {
            if (selectedUser == nil) {
                UserPicker(users: users) { user in
                    selectedUser = user
                }
                .padding(16)
            } else {
                let user = $selectedUser.map(transform: {user in user!})
                
                PinReader(user:user) { pin in
                    return userHandler.logIn(user: selectedUser!, pin: pin)
                }
            }
        }
        .navigationTitle("Bejelentkezés")
        .toolbar{
            if selectedUser != nil {
                Button("Vissza") {
                    selectedUser = nil
                }
                .font(.jbBody)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView(users: User.sampleData)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
