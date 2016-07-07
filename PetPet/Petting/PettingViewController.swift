
import Cleanse
import RxCocoa
import RxSwift
import UIKit

class PettingViewController: ViewController {
  // MARK: Properties
  private var model: PettingViewModel!
  private let subscriptions = DisposeBag()

  // MARK: Outlets
  @IBOutlet weak var petView: PetView!

  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    subscriptions <- model.pet().subscribeNext { pet in
      self.petView.bind(pet)
    }
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBarHidden = true
  }
}

// MARK: Module
extension PettingViewController: Bindable {
  func bind(model: PettingViewModel) {
    self.model = model
  }

  struct Module: Cleanse.Module {
    func configure<B : Binder>(binder binder: B) {
      binder.bind().to(factory: PettingViewController.create)
    }
  }
}
