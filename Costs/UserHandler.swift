import Foundation

enum LogInResult {
    case Success, Error
}

@MainActor
class UserHandler: ObservableObject {
    @Published var loggedInUser: User?
    var isLoggedIn: Bool {
        loggedInUser != nil
    }
    
    func logIn(user: User, pin: String) -> LogInResult {
        if(user.pin == pin) {
            loggedInUser = user
            return LogInResult.Success
        } else {
            return LogInResult.Error
        }
    }
    
    func logOut() -> Void {
        loggedInUser = nil
    }
}
