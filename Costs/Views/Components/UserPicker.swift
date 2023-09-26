import SwiftUI

struct UserPicker: View {
    let users: [User];
    var handler: ((User) -> Void)
    
    private let columns = 4;
    private let sp = CGFloat(40)
    private var gridColumns: Array<GridItem> { Array(repeating: GridItem(spacing: sp), count: columns) }
    
    var body: some View {
        VStack {
            GeometryReader { gp in
                LazyVGrid(columns: gridColumns, spacing: sp) {
                    ForEach(users, id: \.name) { user in
                        Button {
                            handler(user)
                        } label: {
                            Text(user.name)
                                .frame(width: gp.size.width / CGFloat(columns) - sp, height: 96)
                                .buttonStyle(font: .jbBodyLarge)
                        }
                    }
                }
            }
        }
    }
}

struct UserPicker_Previews: PreviewProvider {
    static var previews: some View {
        UserPicker(
            users: User.sampleData,
            handler: {user in print("ok")}
        )
    }
}
