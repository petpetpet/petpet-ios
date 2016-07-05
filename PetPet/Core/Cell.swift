
import UIKit

class Cell: UICollectionViewCell {
  // MARK: UIVIew
  override var bounds: CGRect { didSet {
    // UICollectionViewCell doesn't resize its content view at the right time
    contentView.frame = bounds
  }}

  // MARK: View Lifecycle
  override func awakeAfterUsingCoder(decoder: NSCoder) -> AnyObject? {
    return replace(self) ?? super.awakeAfterUsingCoder(decoder)
  }
}
