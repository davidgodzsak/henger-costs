import SwiftUI

@main
struct CostsApp: App {
    
    init() {
        let appearance = UINavigationBar.appearance()
        appearance.largeTitleTextAttributes = [.font : UIFont(name: Font.fontName(weight: .regular), size: 48)! ]
        appearance.titleTextAttributes = [.font : UIFont(name: Font.fontName(weight: .regular), size: 24)! ]
        appearance.barTintColor = UIColor.white
        appearance.shadowImage = UIImage()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginView(users: User.sampleData)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
