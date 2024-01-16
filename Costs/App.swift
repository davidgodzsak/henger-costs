import SwiftUI
import RealmSwift
import Foundation

private let appConfig: AppConfig = loadAppConfig()

@main
 struct CostsApp: SwiftUI.App {
    @StateObject var userHandler = UserHandler()
    @StateObject var realmManager = RealmManager(appConfig.realmConfig)
    
    init() {
        setupAppearance()
    }

    var body: some Scene {
        WindowGroup {
            VStack {
                if let realmConfiguration = realmManager.configuration  {
                    AutoOpenView()
                        .environment(\.realmConfiguration, realmConfiguration)
                        .environmentObject(userHandler)
                        .environmentObject(realmManager)
                } else {
                    Image("HengerLogo")
                        .resizable()
                        .frame(width: 256, height: 256)
                }
            }
            .task {
                try? await realmManager.configure()
            }
        }
    }
    
    private func setupAppearance() {
        let appearance = UINavigationBar.appearance()
        appearance.largeTitleTextAttributes = [.font : UIFont(name: Font.fontName(weight: .regular), size: 40)!]
        appearance.titleTextAttributes = [.font : UIFont(name: Font.fontName(weight: .regular), size: 24)!]
        appearance.barTintColor = UIColor.white
        appearance.shadowImage = UIImage()
    }
}



// TODO: USE ASYMETRIC https://www.mongodb.com/docs/realm/sdk/swift/sync/stream-data-to-atlas/
// TODO: USE AUDIOT LOG https://www.mongodb.com/docs/realm/sdk/swift/sync/event-library/
// TODO: CHECK NETWORK CONNECTION https://www.mongodb.com/docs/realm/sdk/swift/sync/network-connection/
// TODO: CHECK UPLOAD DOWNLOAD PROGRESS https://www.mongodb.com/docs/realm/sdk/swift/sync/sync-progress/
// TODO: HANDLE ERRORS https://www.mongodb.com/docs/realm/sdk/swift/sync/handle-sync-errors/
struct AutoOpenView: View {
    @EnvironmentObject var realmManager: RealmManager
    @AutoOpen(appId: appConfig.realmConfig.appId, timeout: 1000) var autoOpen
    
    var body: some View {
        switch autoOpen {
            case .connecting:
                Image("HengerLogo")
                    .resizable()
                    .frame(width: 256, height: 256)
                ProgressView("Csatlakozás...")
            case .waitingForUser:
                Image("HengerLogo")
                    .resizable()
                    .frame(width: 256, height: 256)
                ProgressView("Bejelentkezés...")
            case .open(let realm):
                ContentView()
                    .environment(\.realm, realm)
                    .environmentObject(realmManager)
            case .error(let error):
                let _ = print(error)
            Text("Hiba " + Emoji.random(EmojiType.sad))
            case .progress(let progress):
                Image("HengerLogo")
                    .resizable()
                    .frame(width: 256, height: 256)
            
                ProgressView(progress)
                .progressViewStyle(.circular)
        }
    }
}
