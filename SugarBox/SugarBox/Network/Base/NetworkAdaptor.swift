//
//  NetworkAdapter.swift
//  SugarBox
//
//  Created by abdul karim on 21/10/23.
//

import Foundation
import Alamofire

let networkAdapterErrorDomain = "com.SugarBox"
public class HttpResponseError: NSError {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Custom Initializer.
    ///
    /// - Parameters:
    ///   - statusCode: Http Status Code.
    ///   - serverErrorCode: Error Code sent from the server in response body.
    ///   - serverErrorDescription: Error Description sent from the server in response body.
    public init(domain: String?, statusCode: Int, serverErrorDescription: String?) {
        super.init(domain: domain != nil ? domain! : "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: serverErrorDescription != nil ? serverErrorDescription!: ""])
    }
}

/// Network Adapter for routing all the Requests. It is a wrapper around Alamofire Request method to provide custom hooks for the requests and response.

public class NetworkAdapter {
    
    private static var reachability: Reachability { try! Reachability() }

    public class func request(_ urlRequest: URLRequestConvertible,
                              completionHandler: @escaping (Any) -> Void,
                              errorHandler: @escaping (NSError) -> Void,
                              networkErrorHandler: @escaping () -> Void) {
        
        if reachability.connection != .unavailable {
            AF.request(urlRequest)
                .validate()
                .responseJSON { response in
                    if let value = response.value {
                        completionHandler(value)
                    } else {
                        errorHandler(handleErrorFor(response: response))
                    }
                }
                .cURLDescription { curl in
                    print(curl)
                }
        } else {
            networkErrorHandler()
        }
    }

    
    /// Method to create and return HttpResponseError if error is encountered
    ///
    /// - Parameter response: Data Response received from the Server.
    /// - Returns: HttpResponseError Object.
    private class func handleErrorFor<Success>(response: AFDataResponse<Success>) -> HttpResponseError {
        if response.error?.responseCode == 401 {
            debugPrint("Client request has not been completed")
        }
        
        var responseDictionary = [String: Any]()
        if let data = response.data {
            do {
                if let responseDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    responseDictionary = responseDict
                }
            } catch {
                debugPrint(error)
            }
        }
        if let errorDictionary = responseDictionary["error"] as? [String: Any] {
            return HttpResponseError(domain: networkAdapterErrorDomain, statusCode: response.response!.statusCode, serverErrorDescription: errorDictionary["description"] as? String)
        }
        if let message = responseDictionary["message"] as? String {
            return HttpResponseError(domain: networkAdapterErrorDomain, statusCode: response.response!.statusCode, serverErrorDescription: message)
        }
        if response.response != nil {
            return HttpResponseError(domain: networkAdapterErrorDomain, statusCode: response.response!.statusCode, serverErrorDescription: nil)
        } else {
            return HttpResponseError(domain: networkAdapterErrorDomain, statusCode: HTTPStatusCode.requestTimeout.rawValue, serverErrorDescription: nil)
        }
    }
}
