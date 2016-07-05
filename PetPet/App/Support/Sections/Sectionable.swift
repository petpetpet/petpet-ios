
protocol Sectionable {
  func sections(with builder: Sections.Builder)
}

extension Sectionable {
  func sections() -> Sections {
    let builder = Sections.Builder()
    sections(with: builder)
    return builder.build()
  }
}
