//
//  APIService.swift
//  SugarBox
//
//  Created by abdul karim on 21/10/23.
//

import Foundation

class APIService {

    func getContent(queryParams:QueryParams, successCallback: @escaping ((_ response: JSON?) -> Void), errorCallback: @escaping ((_ error: Error) -> Void), networkErrorCallback: @escaping (() -> Void)) {
        NetworkAdapter.request(BaseRouter.baseRouterManager(Router.getContents(queryParams)), completionHandler: { (response) in
            if let responseJSON = response as? JSON {
                successCallback(responseJSON)
            }
            else {
                errorCallback(APIError.parseError)
            }
        }, errorHandler: { (error) in
            errorCallback(error)
        }) {
            networkErrorCallback()
        }
    }
    
    func getContents(queryParams:QueryParams) async throws -> JSON {
        return try await withCheckedThrowingContinuation { continuation in
            NetworkAdapter.request(BaseRouter.baseRouterManager(Router.getContents(queryParams)), completionHandler: { (response) in
                if let responseJSON = response as? JSON {
                    continuation.resume(returning: responseJSON)
                } else {
                    continuation.resume(throwing: APIError.parseError)
                }
            }, errorHandler: { (error) in
                continuation.resume(throwing: error)
            }) {
                //network error
                continuation.resume(throwing: APIError.noInternetAvailable)
            }
            
        }
    }
}
