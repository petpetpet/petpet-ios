
import Foundation

struct Id {
  private let value: NSUUID

  init() {
    value = NSUUID()
  }
}

// MARK: Hashable
extension Id: Hashable {
  var hashValue: Int {
    return value.hashValue
  }
}

// MARK: Equatable
func ==(lhs: Id, rhs: Id) -> Bool {
  return lhs.value == rhs.value
}
