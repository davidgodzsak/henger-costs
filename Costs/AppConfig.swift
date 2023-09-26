import Foundation
import RealmSwift

struct RealmConfig {
    let appId: String
    let baseUrl: String
    let apiKey: String
}

struct AppConfig {
    let realmConfig: RealmConfig
}

func loadAppConfig() -> AppConfig {
    guard let path = Bundle.main.path(forResource: "Config", ofType: "plist") else {
        fatalError("Could not load Config.plist file!")
    }

    let data = NSData(contentsOfFile: path)! as Data
    let configPropertyList = try! PropertyListSerialization.propertyList(from: data, format: nil) as! [String: Any]
    
    let realmConfig = extractRealmConfig(configPropertyList)

    return AppConfig(realmConfig: realmConfig)
}


private func extractRealmConfig(_ configPropertyList: [String: Any]) -> RealmConfig {
    let db = configPropertyList["Realm"] as! Dictionary<String, Any>

    let appId = db["AppId"]! as! String
    let baseUrl = db["BaseUrl"]! as! String
    let apiKey = db["ApiKey"]! as! String
 
    return RealmConfig(appId: appId, baseUrl: baseUrl, apiKey: apiKey)
}
