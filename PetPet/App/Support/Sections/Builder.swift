
import UIKit
import RxSwift

// MARK: Sections
extension Sections {
  class Builder {
    private var _sections: [Section] = []
    private var _delegate: UICollectionViewDelegate?
  }
}

extension Sections.Builder {
  func section(configure: Section.Builder -> Void) -> Self {
    let builder = Section.Builder()
    configure(builder)
    _sections.append(builder.build())
    return self
  }

  func delegate(delegate: UICollectionViewDelegate) -> Self {
    _delegate = delegate
    return self
  }

  func build() -> Sections {
    return Sections(sections: _sections, delegate: _delegate)
  }
}

// MARK: Section
extension Section {
  class Builder {
    private var _content: AnyAdapter?
    private var _supplementary: [String: AnyAdapter] = [:]
  }
}

extension Section.Builder {
  // MARK: Content
  func cell<V: Cell where V: Adaptable>(type: V.Type, configure: AdapterBuilder<V> -> Void) -> Self {
    let builder = AdapterBuilder(type: type)
    configure(builder)
    return content(builder.build())
  }

  func content<A: AdapterType where A.View: Cell>(adapter: A) -> Self {
    _content = adapter
    return self
  }

  // MARK: Supplementary
  func header<V: ReusableView where V: Adaptable>(type: V.Type, configure: AdapterBuilder<V> -> Void) -> Self {
    return view(UICollectionElementKindSectionHeader, type, configure: configure)
  }

  func view<V: ReusableView where V: Adaptable>(kind: String, _ type: V.Type, configure: AdapterBuilder<V> -> Void) -> Self {
    let builder = AdapterBuilder(type: type)
    configure(builder)
    return supplementary(kind, builder.build())
  }

  func supplementary<A: AdapterType where A.View: ReusableView>(kind: String, _ adapter: A) -> Self {
    _supplementary[kind] = adapter
    return self
  }

  // MARK: Build
  func build() -> Section {
    guard let content = _content else {
      fatalError("attempted to build `Section` with no content adapter")
    }

    return Section(
      content: content,
      supplementary: _supplementary)
  }
}

// MARK: Adapater
class AdapterBuilder<V: Adaptable> {
  private let type:   V.Type
  private var stream: Observable<[V.Model]>?

  // MARK: Initialization
  init(type: V.Type) {
    self.type = type
  }
}

extension AdapterBuilder {
  func data(stream: Observable<V.Model>) -> Self {
    return data(stream.map { [$0] })
  }

  func data(stream: Observable<[V.Model]>) -> Self {
    self.stream = stream
    return self
  }

  func build() -> AdapterProxy<V> {
    guard let stream = stream else {
      fatalError("no stream provided to build `Adapter`")
    }

    return AdapterProxy(adapter: StreamAdapter<V>(stream: stream))
  }
}
