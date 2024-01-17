import Foundation

struct ConversionResponse: Codable {
    let targetServiceUrl: String
    let originService: String
}

class ShareSongClient {
    // Prevent instantiation
    private init() {}

    static func convert(originServiceUrl: String, targetService: String) async throws -> ConversionResponse {
        let baseUrl = "https://convert-f47vs76u2q-ew.a.run.app"
        guard var urlComponents = URLComponents(string: baseUrl) else {
            throw URLError(.badURL)
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "originServiceUrl", value: originServiceUrl),
            URLQueryItem(name: "targetService", value: targetService)
        ]

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        print("data")
        print(data)
        print(urlResponse)
        
        
                 if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                 }
               
        
        return try JSONDecoder().decode(ConversionResponse.self, from: data)
    }
}

