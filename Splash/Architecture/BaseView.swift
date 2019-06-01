
import UIKit

/// View layer abstract
protocol BaseView: class where Self: UIViewController {
  associatedtype PresenterType
  var presenter: PresenterType? { set get }
  
  func showError(title: String?, message: String?, okAction: (() -> ())?) 
  func showNavigationBar(animated: Bool)
  func hideNavigationBar(animated: Bool)
}

extension BaseView {
  
  func showError(title: String?, message: String?, okAction: (() -> ())?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in okAction?() }))
    present(alert, animated: true, completion: nil)
  }
  
  func showNavigationBar(animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  func hideNavigationBar(animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
}




