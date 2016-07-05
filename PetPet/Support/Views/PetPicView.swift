
import UIKit
import AlamofireImage

final class PetPicView: View, Replaceable {
  // MARK: Outlets
  @IBOutlet weak var imageView: UIImageView!

  // MARK: View Lifecycle
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = bounds.size.width / 2
  }

  // MARK: Image Loading
  func load(image image: State.Image) {
    guard let url = NSURL(string: image.url) else { return }
    imageView.af_setImageWithURL(url)
  }
}
