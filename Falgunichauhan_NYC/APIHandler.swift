//
//  APIHandler.swift
//  Falgunichauhan_NYC
//
//  Created by Falguni Chauhan on 1/19/23.
//

import Foundation


enum URLString {
    static let nycSchoolDirectory = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    static let satScore = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn="
}

typealias Completion<T: Codable> = ((Result<T, Error>) -> Void)?

protocol APIService {
//    func fetchData<T: Codable>(urlString: String, of: T.Type, completion: Completion<T>) -> Void
    func fetchData<T: Codable>(urlString: String, with dbn: String?, of: T.Type, completion: Completion<T>) -> Void
}

class APIHandler: APIService {

    enum APIError: Error {
        case failedToCreateURL
        case errorFetchingData(error: String)
    }

    private var session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchData<T: Codable>(urlString: String, with dbn: String? = nil, of: T.Type, completion: Completion<T>) where T: Decodable {


        guard let url = URL(string: urlString + (dbn ?? "")) else {
            completion?(.failure(APIError.failedToCreateURL))
            return
        }

        let task = session.dataTask(with: url) { data, response, error in

            guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion?(.failure(APIError.errorFetchingData(error: String(describing: error))))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion?(.success(decodedData))
            }
            catch(let decodingError) {
                completion?(.failure(decodingError))
            }
        }
        task.resume()
    }
}

extension String: Error { }
