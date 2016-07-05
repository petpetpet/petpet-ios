
// MARK: Concat
extension RangeReplaceableCollectionType {
  func concat(element: Generator.Element) -> Self {
    var result = self
    result.append(element)
    return self
  }
}

// MARK: Unique
extension SequenceType where Generator.Element: Hashable {
  func uniq() -> AnySequence<Generator.Element> {
    return AnySequence(Set(self))
  }
}
