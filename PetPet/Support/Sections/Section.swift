
import UIKit
import RxSwift

struct Section {
  let id = Id()
  let content: AnyAdapter
  let supplementary: [String: AnyAdapter]
}

// MARK: Changes
extension Section {
  func changes() -> Observable<Id> {
    return adapterChanges()
      .merge()
      .map { _ in self.id }
  }

  private func adapterChanges() -> Observable<Observable<Change>> {
    return supplementary.values
      .map { $0.changes() }
      .concat(content.changes())
      .toObservable()
  }
}
