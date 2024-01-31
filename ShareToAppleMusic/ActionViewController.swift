import MobileCoreServices
import SwiftUI
import UIKit
import UniformTypeIdentifiers

/// A UI Kit ViewController that houses a SwiftUI View
class ActionViewController: UIViewController {
    let uiHostingController = UIHostingController(rootView: LoadingAnimation())

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

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        extensionContext!.completeRequest(returningItems: extensionContext!.inputItems, completionHandler: nil)
    }
}
