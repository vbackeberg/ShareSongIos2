import Foundation
import SwiftUI
import UIKit
import UniformTypeIdentifiers

class BaseActionViewController: UIViewController {
    var targetServiceName: String { "" }
    var targetServiceDisplayName: String { targetServiceName }
    
    private lazy var uiHostingController = UIHostingController(rootView: LoadingScreen(close: close))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(uiHostingController)
        view.addSubview(uiHostingController.view)
        setupConstraints()
        
        guard let inputItem = extensionContext?.inputItems.first as? NSExtensionItem else { return }
        guard let itemProvider = inputItem.attachments?.first else { return }
        if !itemProvider.hasItemConformingToTypeIdentifier(UTType.url.identifier) { return }
            
        itemProvider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) {
            [weak self] url, error in
            DispatchQueue.main.async {
                if let strongSelf = self, let url = url as? URL {
                    if !strongSelf.shouldActivateForURL(url) {
                        let alert = UIAlertController(
                            title: "Error",
                            message: "Sorry, this link is not supported. We can only convert songs.",
                            preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                            strongSelf.close()
                        }))
                        DispatchQueue.main.async {
                            strongSelf.present(alert, animated: true)
                        }
                        
                    } else {
                        print("transforming url")
                        print(url)
                        
                        Task {
                            do {
                                let conversionResponse = try await ShareSongClient.convert(
                                    originServiceUrl: url.absoluteString,
                                    targetService: strongSelf.targetServiceName)
                                
                                print("Successful conversion: \(conversionResponse)")
                                
                                let targetServiceUrl = URL(string: conversionResponse.targetServiceUrl)!
                                
                                strongSelf.shareURL(targetServiceUrl, self: strongSelf)
                                
                            } catch {
                                print("Error: \(error)")
                                
                                // Show an alert
                                let alert = UIAlertController(
                                    title: "Error",
                                    message: "Sorry, your song could not be converted. Maybe, it wasn't found on \(strongSelf.targetServiceDisplayName).",
                                    preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                    strongSelf.close()
                                }))
                                DispatchQueue.main.async {
                                    strongSelf.present(alert, animated: true)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    /// Sets the layout constraints for the SwiftUI view
    private func setupConstraints() {
        uiHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        uiHostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        uiHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        uiHostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        uiHostingController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    /// - Returns true if URL matches one of the allowed url regex patterns.
    private func shouldActivateForURL(_ url: URL) -> Bool {
        if OriginUrls.allowedURLs.allSatisfy(
            {
                (regex: NSRegularExpression) -> Bool in regex.numberOfMatches(
                    in: url.absoluteString,
                    range: NSMakeRange(0, url.absoluteString.count)) == 0
            })
        {
            print("URL is not supported")
            print(url.absoluteString)
            return false
        }
        return true
    }
    
    /// Opens a share sheet with the new URL.
    private func shareURL(_ url: URL, self: BaseActionViewController) {
        let items = [url]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = { _, _, _, _ in
            self.close()
        }
        
        present(activityViewController, animated: true)
    }
    
    private func close() {
        extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
}
