
import UIKit
import Cleanse
import RxSwift
import RxCocoa

class PetsViewController: ViewController {
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

    collectionView.registerNib(UINib.init(nibName: "PetCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "PetCell")

    subscriptions <- model
      .pets()
      .bindTo(collectionView.rx_itemsWithCellIdentifier("PetCell", cellType: PetCell.self)) { index, pet, cell in
        print("cell")
      }
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
