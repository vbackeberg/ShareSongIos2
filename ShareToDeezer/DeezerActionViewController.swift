class DeezerActionViewController: BaseActionViewController {
    override var targetServiceName: String { "Deezer" }

    @IBAction func done() {
        close()
    }
}