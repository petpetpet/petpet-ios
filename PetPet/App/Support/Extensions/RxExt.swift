
import RxSwift

infix operator <- { }
func <-(bag: DisposeBag, disposable: Disposable?) {
  if let disposable = disposable {
    bag.addDisposable(disposable)
  }
}
