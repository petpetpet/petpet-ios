
import Foundation
import RxSwift

class StreamAdapter<V: Adaptable> {
  typealias View = V

  // MARK: Properties
  private let _changes: Observable<Change>
  private var _subscription: Disposable?

  private var models: [V.Model] = []

  // MARK: Initialization
  convenience init(stream: Observable<[V.Model]>) {
    self.init(
      stream:  stream,
      changes: stream.map { _ in .change })
  }

  required init(stream: Observable<[V.Model]>, changes: Observable<Change>) {
    _changes = changes
    _subscription = stream.subscribeNext { [weak self] models in
      self?.models = models
    }
  }
}

// MARK: AdapterType
extension StreamAdapter: AdapterType {
  func count() -> Int {
    return models.count
  }

  func model(at indexPath: NSIndexPath) -> V.Model {
    return models[indexPath.item]
  }

  func changes() -> Observable<Change> {
    return _changes
  }
}