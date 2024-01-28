import Foundation

struct OriginUrls {
    static var regexSpotify: NSRegularExpression?
    static var regexDeezer: NSRegularExpression?
    static var regexTidal: NSRegularExpression?
    static var regexAppleMusic: NSRegularExpression?
    static var regexYouTubeMusic: NSRegularExpression?

    static let allowedURLs: [NSRegularExpression] = {
        do {
            regexSpotify = try NSRegularExpression(pattern: "https://open\\.spotify\\.com/(?:.+/)?track/\\w+")
            regexDeezer = try NSRegularExpression(pattern: "https://deezer\\.page\\.link/\\w+")
            regexTidal = try NSRegularExpression(pattern: "https://tidal\\.com/track/\\d+")
            regexAppleMusic = try NSRegularExpression(pattern: "https://music\\.apple\\.com/[a-z]{2}/album/[^/]+/\\d+\\?i=\\d+")
            regexYouTubeMusic = try NSRegularExpression(pattern: "https://music\\.youtube\\.com/watch\\?v=.+")
        } catch {
            print("Error creating regex: \(error)")
        }

        return [regexSpotify!, regexDeezer!, regexTidal!, regexAppleMusic!, regexYouTubeMusic!]
    }()
}

// In info.plist, we register the app for above domains.
//
//<key>NSExtensionActivationRule</key>
//<dict>
//    <key>NSExtensionActivationSupportsWebURLWithMaxCount</key>
//    <integer>1</integer>
//    <key>NSExtensionActivationUsesStrictMatching</key>
//    <integer>1</integer>
//    <key>NSPredicate</key>
//    <string>SUBQUERY (
//        extensionItems,
//        $extensionItem,
//        SUBQUERY (
//            $extensionItem.attachments,
//            $attachment,
//            ANY $attachment.registeredTypeIdentifiers UTI-CONFORMS-TO "public.url" AND
//            (
//                [NSPredicate predicateWithFormat:@"SELF LIKE[c] '*spotify.com*'"].evaluateWithObject($attachment.URL.host) OR
//                [NSPredicate predicateWithFormat:@"SELF LIKE[c] '*deezer.page.link*'"].evaluateWithObject($attachment.URL.host) OR
//                [NSPredicate predicateWithFormat:@"SELF LIKE[c] '*tidal.com/track*'"].evaluateWithObject($attachment.URL.host)
//            )
//        ).@count == $extensionItems.@count
//    ).@count == 1</string>
//</dict>
