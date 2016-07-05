
import Cleanse

extension Binder {
  func install<M : Module>(module module: M) -> Self {
    install(module: module)
    return self
  }
}
