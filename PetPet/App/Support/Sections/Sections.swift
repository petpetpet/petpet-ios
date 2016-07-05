
import UIKit
import RxSwift

class Sections: NSObject {
  private let sections:       [Section]
  private var collectionView: UICollectionView?
  private let delegate:       UICollectionViewDelegate?
  private var subscription:   Disposable?

  // MARK: Initialization
  init(sections: [Section], delegate: UICollectionViewDelegate?) {
    self.sections = sections
    self.delegate = delegate
  }

  // MARK: Configuration
  func attach(to collectionView: UICollectionView) {
    // let's just go ahead and lean on each other
    self.collectionView = collectionView
    collectionView.dataSource = self
    collectionView.delegate   = self

    // subscribe to section changes
    subscription?.dispose()
    subscription = changes().subscribeNext(changed)
  }
}

// MARK: Changes
private extension Sections {
  private func changes() -> Observable<AnySequence<Id>> {
    return sections
      .map { $0.changes() }.toObservable()
      .merge()
      .buffer(timeSpan: 0.0, scheduler: Schedulers.main)
      .filter { !$0.isEmpty }
      .map { $0.uniq() }
  }

  private func changed(sections: AnySequence<Id>) {
    collectionView?.reloadData()
  }
}

// MARK: UICollectionViewDataSource
extension Sections: UICollectionViewDataSource {
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return sections.count
  }

  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return adapter(in: section).count()
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let content = adapter(in: indexPath.section)
    let result: UICollectionViewCell = content.dequeue(kind: nil, from: collectionView, at: indexPath)
    return result
  }

  func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    let supplement = adapter(of: kind, in: indexPath.section)
    let result: UICollectionReusableView = supplement.dequeue(kind: kind, from: collectionView, at: indexPath)
    return result
  }
}

// MARK: UICollectionViewDelegate
extension Sections: UICollectionViewDelegate {
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    delegate?.collectionView?(collectionView, didSelectItemAtIndexPath: indexPath)
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension Sections: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout _layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    if let result = proxy?.collectionView?(collectionView, layout: _layout, sizeForItemAtIndexPath: indexPath) {
      return result
    }

    let content = adapter(in: indexPath.section)
    let result  = content.sizeable().estimatedSize(given: collectionView.bounds.size)

    return result
  }

  func collectionView(collectionView: UICollectionView, layout _layout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    if let result = proxy?.collectionView?(collectionView, layout: _layout, referenceSizeForHeaderInSection: section) {
      return result
    }

    let supplement = adapter(of: UICollectionElementKindSectionHeader, in: section)
    let result     = supplement.sizeable().estimatedSize(given: collectionView.bounds.size)

    return result
  }

  // MARK: Helpers
  private func estimatedSize(in section: Int, given container: CGSize) -> CGSize {
    let content = adapter(in: section)
    let result  = content.sizeable().estimatedSize(given: container)

    return result
  }

  private var proxy: UICollectionViewDelegateFlowLayout? {
    return delegate as? UICollectionViewDelegateFlowLayout
  }
}

// MARK: Helpers
private extension Sections {
  private func adapter(in sectionIndex: Int) -> AnyAdapter {
    return sections[sectionIndex].content
  }

  private func adapter(of kind: String, in sectionIndex: Int) -> AnyAdapter {
    guard let adapter = sections[sectionIndex].supplementary[kind] else {
      fatalError("no adapter for supplementary view of kind \(kind) found in section \(sectionIndex)")
    }
    
    return adapter
  }
}