import MobileCoreServices
import SwiftUI
import UIKit
import UniformTypeIdentifiers

/// A UI Kit ViewController that houses a SwiftUI View
class AppleMusicActionViewController: BaseActionViewController {
    override var targetServiceName: String { "AppleMusic" }
    override var targetServiceDisplayName: String { "Apple Music" }
}
