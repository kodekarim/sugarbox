//
//  BaseRouterProtocol.swift
//  SugarBox
//
//  Created by abdul karim on 21/10/23.
//


import Foundation
import Alamofire

public typealias RequestHeaders = [String: String]
public typealias RequestBody = [String: Any]
public typealias QueryParams = [String: Any]
public typealias PathParams = [String: Any]
public typealias ResponseObject = [String: Any]
public typealias JSON = [String: Any]

protocol BaseRouterProtocol {

    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var parameters: Alamofire.Parameters? { get }
    var body: AnyObject? { get }
    var headers: [String: String]? { get }
}
