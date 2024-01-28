import MobileCoreServices
import UIKit
import UniformTypeIdentifiers

class SpotifyActionViewController: BaseActionViewController {
    override var targetServiceName: String { "Spotify" }
    
    @IBAction func done() {
        close()
    }
}
