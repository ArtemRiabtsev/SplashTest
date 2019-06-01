
import Foundation

class BaseRouter<ViewType: BaseView> {
  weak var view: ViewType?
  
  required init(view: ViewType) {
    self.view = view
  }
}
