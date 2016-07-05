
import RxSwift
import UIKit

infix operator <- { }
func <-(bag: DisposeBag, disposable: Disposable?) {
  if let disposable = disposable {
    bag.addDisposable(disposable)
  }
}

extension ObservableType {
  func buffer(timeSpan timeSpan: RxTimeInterval, scheduler: SchedulerType) -> Observable<[E]> {
    return buffer(timeSpan: timeSpan, count: Int.max, scheduler: scheduler)
  }
}
