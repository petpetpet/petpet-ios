
import UIKit

class View: UIView {
  // MARK: View Lifecycle
  override func awakeAfterUsingCoder(decoder: NSCoder) -> AnyObject? {
    return replace(self) ?? super.awakeAfterUsingCoder(decoder)
  }
}
