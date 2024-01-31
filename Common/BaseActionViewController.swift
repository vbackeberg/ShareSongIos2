import Foundation
import UIKit
import UniformTypeIdentifiers

class BaseActionViewController: UIViewController {
    var targetServiceName: String { "" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let inputItem = extensionContext?.inputItems.first as? NSExtensionItem else { return }
        guard let itemProvider = inputItem.attachments?.first else { return }
        if !itemProvider.hasItemConformingToTypeIdentifier(UTType.url.identifier) { return }
            
        itemProvider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) {
            [weak self] url, error in
            DispatchQueue.main.async {
                if let strongSelf = self, let url = url as? URL {
                    if !strongSelf.shouldActivateForURL(url) {
                        strongSelf.extensionContext?.cancelRequest(
                            withError: NSError(domain: "URL not supported", code: 0, userInfo: nil))
                        
                        let alert = UIAlertController(
                            title: "Error",
                            message: "Sorry, this link is not supported. We can only convert songs.",
                            preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        DispatchQueue.main.async {
                            strongSelf.present(alert, animated: true, completion: {
                                strongSelf.close()
                            })
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
                                
                                // Share the new URL
                                strongSelf.shareURL(targetServiceUrl)
                                
                            } catch {
                                print("Error: \(error)")
                                
                                // Show an alert
                                let alert = UIAlertController(
                                    title: "Error",
                                    message: "Sorry, your song could not be converted. Maybe, it wasn't found on \(strongSelf.targetServiceName).",
                                    preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                DispatchQueue.main.async {
                                    strongSelf.present(alert, animated: true, completion: {
                                        strongSelf.close()
                                    })
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    /// - Returns true if URL matches one of the allowed url regex patterns.
    func shouldActivateForURL(_ url: URL) -> Bool {
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
    
    func shareURL(_ url: URL) {
        let items = [url]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: {
            self.close()
        })
    }
    
    func close() {
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
}
