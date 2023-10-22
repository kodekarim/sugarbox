//
//  BaseRouter.swift
//  SugarBox
//
//  Created by abdul karim on 21/10/23.
//

import Foundation
import Alamofire

enum BaseRouter: URLRequestConvertible {
    
    case baseRouterManager(Router)
    
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .baseRouterManager(let request):
            let mutableURLRequest = configureRequest(request)
            return mutableURLRequest
        }
    }
    
    /**
     Configuring Request for each of the cases.
     
     - parameter requestObj: An Object of the Router Protocol.
     - Contains Path of the Request.
     - Contains Method GET, POST, PUT
     - Contains Request Parameters
     - Contains Request Body
     
     - returns: <#return value description#>
     */
    
    func configureRequest(_ requestObj: BaseRouterProtocol, urlString : String? = nil) -> URLRequest {
        
        let url = URL(string: APIConstants.baseURL)!
        
        /// Set Request Path
        var mutableURLRequest = URLRequest(url: url.appendingPathComponent(requestObj.path))
        
        /**
         *  Set Request Method
         */
        mutableURLRequest.httpMethod = requestObj.method.rawValue
        
        //Specific headers example
        if let headers = requestObj.headers {
            for (key, value) in headers {
                mutableURLRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // we can add body too if needed
        
        //// Set Request Parameters.
        if let parameters: Alamofire.Parameters = requestObj.parameters {
            do {
                return try Alamofire.URLEncoding.queryString.encode(mutableURLRequest as URLRequestConvertible, with: parameters)
            } catch {
            }
        }
        return mutableURLRequest
    }
}
