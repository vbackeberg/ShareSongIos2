class SpotifyActionViewController: BaseActionViewController {
    override var targetServiceName: String { "Spotify" }

    @IBAction func done() {
        close()
    }
}
