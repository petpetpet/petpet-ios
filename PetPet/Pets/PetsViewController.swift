
import UIKit
import Cleanse
import RxSwift
import RxCocoa

class PetsViewController: ViewController, Sectionable {
  private var model: PetsViewModel!
  private let subscriptions = DisposeBag()

  // MARK: Outlets
  @IBOutlet weak var collectionView: UICollectionView!

  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    sections().attach(to: collectionView)
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBarHidden = true
  }

  // MARK: Sectionable
  func sections(with builder: Sections.Builder) {
    builder.section { $0
      .header(PetsHeaderView.self) { $0
        .data(self.model.pets()) }
      .cell(PetCell.self) { $0
        .data(self.model.pets()) } }
    .delegate(self)
  }
}

// MARK: UICollectionViewDelegate
extension PetsViewController: UICollectionViewDelegate {
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    resolve(model.selectOption(at: indexPath.item))
  }
}

// MARK: Module
extension PetsViewController {
  struct Module: Cleanse.Module {
    func configure<B: Binder>(binder binder: B) {
      binder.bind().to(factory: PetsViewController.create)
    }
  }

  static func create(model: PetsViewModel) -> Self {
    let result = instance()
    result.model = model
    return result
  }
}
