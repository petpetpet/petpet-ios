
protocol Defaultable {
  static func fallback() -> Self
}

func zero<T: Defaultable>() -> T {
  return T.fallback()
}

func coalesce<T: Defaultable>(value: T?) -> T {
  return value ?? T.fallback()
}

// MARK: Primitives
extension Int: Defaultable {
  static func fallback() -> Int {
    return 0
  }
}

extension String: Defaultable {
  static func fallback() -> String {
    return ""
  }
}
