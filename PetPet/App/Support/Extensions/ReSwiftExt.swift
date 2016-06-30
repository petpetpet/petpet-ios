
import ReSwift
import RxSwift

extension StoreType {
  func changes() -> Observable<State> {
    return Observable.create { subscriber in
      let proxy = ProxySubscriber(proxy: subscriber)
      self.subscribe(proxy)

      return AnonymousDisposable {
        self.unsubscribe(proxy)
      }
    }
  }
}

// MARK: Proxy
private class ProxySubscriber<S: StateType>: StoreSubscriber {
  private let proxy: AnyObserver<S>

  init(proxy: AnyObserver<S>) {
    self.proxy = proxy
  }

  func newState(state: S) {
    proxy.on(.Next(state))
  }
}
