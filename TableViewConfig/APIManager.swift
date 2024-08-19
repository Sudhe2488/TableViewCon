//
//  APIManager.swift
//  TableViewConfig
//
//  Created by Sudheshna Tholikonda on 21/07/24.
//

import Foundation

enum DataError: Error {
    case invalidData
    case invalidResponse
    case message(_ error: Error?)
}

//struct Products:Codable {
//    let id: Int
//   let first_name: String
//   let last_name: String
//   let email: String
//   let avatar: String
//}

class APIManager {
    static let shared = APIManager()
    private init() { }
    var parser = XMLParser()


    let url = URL(fileURLWithPath: "https://news.google.com/rss?cf=all&hl=en-IN&pz=1&gl=IN&ceid=IN:en")
    
// @escaping is used here, because this is a background task.
// If you write a print statemnet after the dataTask completes, i.e. after resume(), then it will execute beforehand.
// This happens because it is time consuming task and can not be implemented on main thread.
//@escaping captures data in memeory.

    func fetchData(completion: @escaping (Result<[Products], Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                completion(.failure(DataError.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            // JSONDecoder() converts data to model of type Array
            do {
                print("JSONDecoder",data)
                let products = try JSONDecoder().decode([Products].self, from: data)
                completion(.success(products))
            }
            catch {
                completion(.failure(DataError.message(error)))
            }
        }.resume()
    }
}
final class ProductView {
    var products: [Products] = []
    
    
}
