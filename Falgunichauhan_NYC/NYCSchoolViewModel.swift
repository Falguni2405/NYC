//
//  NYCSchoolModel.swift
//  Falgunichauhan_NYC
//
//  Created by Falguni Chauhan on 1/19/23.
//

import Foundation

class NYCSchoolViewModel: ObservableObject {

    //MARK: Properties
    @Published var nycSchoolData:[NYCSchool] = []
    @Published var satScore: SATScore?
    private var error: Error?

    //MARK: Methods
    ///We use this method to get flight data from API
    func getData(completionHandler : @escaping (_ success: Bool) -> ()) {
        APIHandler().fetchData(urlString: URLString.nycSchoolDirectory, of: [NYCSchool].self) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.error = error
                completionHandler(false)
            case .success(let data):
                DispatchQueue.main.async {
                    self?.nycSchoolData = data
                    completionHandler(true)
                }
            }
        }
    }

    func getSatData(with schoolDbn: String, completionHandler : @escaping (_ success: Bool) -> ()) {
        APIHandler().fetchData(urlString: URLString.satScore, with: schoolDbn, of: [SATScore].self) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.error = error
                completionHandler(false)
            case .success(let data):
                DispatchQueue.main.async {
                    self?.satScore = data.first
                    completionHandler(true)
                }
            }
        }
    }
}
