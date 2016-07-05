
import UIKit
import Cleanse
import RxSwift
import RxCocoa

class PetsViewController: ViewController, Sectionable {
  private var model: PetsViewModel!
  private let subscriptions = DisposeBag()

  // MARK: Outlets
  @IBOutlet weak var collectionView: UICollectionView!

  // MARK: Initialization
  static func create(model: PetsViewModel) -> Self {
    let result = instance()
    result.model = model
    return result
  }

  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    sections().attach(to: collectionView)
  }

  // MARK: Sectionable
  func sections(with builder: Sections.Builder) {
    builder.section { $0
      .header(PetsHeaderView.self) { $0
        .data(self.model.pets()) }
      .cell(PetCell.self) { $0
        .data(self.model.pets()) } }
  }
}

// MARK: Module
extension PetsViewController {
  struct Module: Cleanse.Module {
    func configure<B: Binder>(binder binder: B) {
      binder.install(module: PetsViewModel.Module())
      binder.bind().to(factory: PetsViewController.create)
    }
  }
}
