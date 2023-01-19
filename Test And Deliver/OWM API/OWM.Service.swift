
import Foundation

// MARK: - OWMService

struct OWMService {
    let service: DataService
    
    func getForecast(lat: Double, lon: Double) async throws -> OWMForecast {
        let request = OWMEndpoints.forecast(lat, lon).request
         
        let result = try await service.load(from: request, convertTo: OWMForecast.self)
        return result
    }
    
    func getForecast(lat: Double, lon: Double, handler: @escaping (Result<OWMForecast, NetworkError>) -> Void) {
        let request = OWMEndpoints.forecast(lat, lon).request
        service.load(from: request, convertTo: OWMForecast.self) { result in
            switch result {
            case .success(let forecast):
                handler(.success(forecast))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
