
import Foundation

final class FileLoadingService {

    func load<A>(resource:Resource<A>, completion: @escaping  (A?) -> ()) {

        DispatchQueue.global(qos: .userInitiated).async {
            let url = Bundle.main.url(forResource: resource.fileName, withExtension: resource.fileExtension)
            if let data = try? Data(contentsOf: url!) {
                let decoder = JSONDecoder()
                let result = try? decoder.decode(A.self, from: data)
                completion(result)
            }
        }
        
    }
}
