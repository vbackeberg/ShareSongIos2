import MobileCoreServices
import SwiftUI
import UIKit
import UniformTypeIdentifiers

/// A UI Kit ViewController that houses a SwiftUI View
class ActionViewController: UIViewController {
    lazy var uiHostingController = UIHostingController(rootView: LoadingScreen(close: close))

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(uiHostingController)
        view.addSubview(uiHostingController.view)
        setupConstraints()
    }

    private func setupConstraints() {
        uiHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        uiHostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        uiHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        uiHostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        uiHostingController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    func close() {
        extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
}
