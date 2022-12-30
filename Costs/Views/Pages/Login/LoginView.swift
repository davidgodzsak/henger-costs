import SwiftUI
import AuthenticationServices

struct LoginView: View {
    let users: [User]
    @State private var selectedUser: User?;
    
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
                PinReader(user: $selectedUser.map(transform: {user in user!}))
            }
        }
        .navigationTitle("Bejelentkezés")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView(users: User.sampleData)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
