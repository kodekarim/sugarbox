//
//  APIRouter.swift
//  SugarBox
//
//  Created by abdul karim on 21/10/23.
//

import Foundation
import Alamofire

enum Router : BaseRouterProtocol {
    
    case getContents(QueryParams)
    
    var path: String {
        switch self {
        case .getContents:
            return APIConstants.contentAPI
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getContents:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getContents(let queryParams):
            return queryParams
        }
    }
    
    var body: AnyObject? {
        switch self {
        default:
            return nil
            
        }
    }
    
    var headers: [String : String]? {
        switch self {
            
        default:
            return nil
        }
    }
}
