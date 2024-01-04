import Foundation

struct ConversionResponse: Codable {
    let targetServiceUrl: String
    let originService: String
}

class ShareSongApi {
    func convert(originServiceUrl: String, targetService: String, completion: @escaping (Result<ConversionResponse, Error>) -> Void) {
        let baseUrl = "https://convert-f47vs76u2q-ew.a.run.app"
        guard var urlComponents = URLComponents(string: baseUrl) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "originServiceUrl", value: originServiceUrl),
            URLQueryItem(name: "targetService", value: targetService)
        ]

        guard let url = urlComponents.url else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }

            do {
                let conversionResponse = try JSONDecoder().decode(ConversionResponse.self, from: data)
                completion(.success(conversionResponse))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
