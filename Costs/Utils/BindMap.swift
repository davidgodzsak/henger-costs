import SwiftUI

extension Binding{
    func map<T>(transform: @escaping (Value) -> T) -> Binding<T> {
        return Binding<T>(get: {transform(self.wrappedValue)}, set: {_ in})
    }
}
