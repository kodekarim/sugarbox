//
//  HomeViewModel.swift
//  SugarBox
//
//  Created by abdul karim on 21/10/23.
//

import Foundation

enum SectionType : String {
    case CarousalWidget = "CarousalWidget"
    case OTTWidget =  "OTTWidget"
}

protocol HomeViewModelDelegates: AnyObject {
    func reloadData()
}

class HomeViewModel {
    
    var apiService:APIService?
    var dataModel:DataModel?
    
    weak var delegate:HomeViewModelDelegates?
    
    init(apiService:APIService) {
        self.apiService = apiService
        getLatestData()
    }
    
    func getLatestData() {
        Task { @MainActor in
            do {
                let contentJSON = try await self.fetchContent()
                let jsonData = try JSONSerialization.data(withJSONObject: contentJSON)
                let contentModel = try JSONDecoder().decode(DataModel.self, from: jsonData)
                dataModel = contentModel
                delegate?.reloadData()
            }
            catch {
                debugPrint("error calling getLatestData() on UserDashboardDetailsViewModel")
            }
            
        }
    }

    fileprivate func fetchContent() async throws -> JSON {
            let queryParam: [String: Any] = [
                PAGE: 1,
                PER_PAGE: 20,
           ]

        let contents = try await apiService?.getContents(queryParams: queryParam) ?? [:]
        return contents
    }
    
    
}
