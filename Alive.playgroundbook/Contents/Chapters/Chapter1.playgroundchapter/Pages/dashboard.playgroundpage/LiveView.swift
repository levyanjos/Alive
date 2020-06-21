import PlaygroundSupport
import ViewControllers

let viewController = DashBoardViewController()
viewController.dashboardView.dropdownButton.isHidden = true
PlaygroundPage.current.setLiveView(viewController)
