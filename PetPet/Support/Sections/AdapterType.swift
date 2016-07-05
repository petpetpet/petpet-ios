
import UIKit
import RxSwift

protocol Adaptable: Bindable, Identifiable, Sizeable {
}

// MARK: AnyAdapter
protocol AnyAdapter {
  func count() -> Int
  func dequeue<O>(kind kind: String?, from collectionView: UICollectionView, at indexPath: NSIndexPath) -> O
  func changes() -> Observable<Change>
  func sizeable() -> Sizeable.Type
}

// MARK: AdapterType
protocol AdapterType: AnyAdapter {
  associatedtype View: Adaptable

  func model(at indexPath: NSIndexPath) -> View.Model
  func dequeue(kind: String?, from collectionView: UICollectionView, at indexPath: NSIndexPath) -> View
}

// MARK: Defaults
extension AdapterType {
  // MARK: Dequeue
  func dequeue(kind: String?, from collectionView: UICollectionView, at indexPath: NSIndexPath) -> View {
    var view: View

    let id = View.identifier()
    if let kind = kind {
      view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: id, forIndexPath: indexPath) as! View
    } else {
      view = collectionView.dequeueReusableCellWithReuseIdentifier(id, forIndexPath: indexPath) as! View
    }

    view.bind(model(at: indexPath))

    return view
  }

  func dequeue<O>(kind kind: String?, from collectionView: UICollectionView, at indexPath: NSIndexPath) -> O {
    return dequeue(kind, from: collectionView, at: indexPath) as! O
  }

  // MARK: Sizing
  func sizeable() -> Sizeable.Type {
    return View.self
  }
}
