import UIKit
import MobileCoreServices


class ActionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the input item
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
                    itemProvider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil) { [weak self] (url, error) in
                        DispatchQueue.main.async {
                            if let strongSelf = self, let url = url as? URL {
                               
                                print("transforming url")
                                print(url)
                                      
                                Task {
                                    do {
                                        let conversionResponse = try await ShareSongApi.convert(
                                            originServiceUrl: url.absoluteString,
                                            targetService: "AppleMusic")
                                        
                                        

                                        print("Successful conversion: \(conversionResponse)")
                                        
                                        let targetServiceUrl = URL(string: conversionResponse.targetServiceUrl)!
                                       
                                        // Share the new URL
                                        strongSelf.shareURL(targetServiceUrl)

                                    } catch {
                                        print("Error: \(error)")

                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
        
    func shareURL(_ url: URL) {
        let items = [url]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        // Present the share sheet
        self.present(activityViewController, animated: true, completion: {
            // Optionally, you can perform actions after the share sheet is dismissed.
        })
    }
    
    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so
    }
}
