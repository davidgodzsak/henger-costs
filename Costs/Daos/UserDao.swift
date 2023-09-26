import RealmSwift

struct UserDao {
    let realm: Realm
    
     func getUsers() -> Result<StoredUser> {
        return realm
            .objects(StoredUser.self)
            .where { user in user.active == true}
            .sorted(byKeyPath: "name")
    }
}
