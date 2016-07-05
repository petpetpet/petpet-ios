
import UIKit
import RxSwift

struct AdapterProxy<V: Adaptable> {
  typealias View = V

  // MARK: Proxy
  private let _count: () -> Int
  private let _dequeue: (kind: String?, from: UICollectionView, at: NSIndexPath) -> V
  private let _changes: () -> Observable<Change>

  // MARK: Initialization
  init<A: AdapterType where A.View == V>(adapter: A) {
    _count   = adapter.count
    _dequeue = adapter.dequeue
    _changes = adapter.changes
  }
}

// MARK: AdapterType
extension AdapterProxy: AdapterType {
  func count() -> Int {
    return _count()
  }

  func dequeue(kind: String?, from collectionView: UICollectionView, at indexPath: NSIndexPath) -> View {
    return _dequeue(kind: kind, from: collectionView, at: indexPath)
  }

  func changes() -> Observable<Change> {
    return _changes()
  }

  func model(at indexPath: NSIndexPath) -> V.Model {
    fatalError("`AdapterProxy` does not provide `model(at:)`")
  }
}
