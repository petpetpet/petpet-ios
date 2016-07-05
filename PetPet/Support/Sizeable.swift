
import CoreGraphics

protocol Sizeable {
  static func estimatedSize(given container: CGSize) -> CGSize
}
