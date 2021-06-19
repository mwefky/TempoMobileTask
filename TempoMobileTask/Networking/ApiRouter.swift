//
//  Network.swift
//  OrcasMobileTask
//
//  Created by mina wefky on 07/03/2021.
//

import Foundation
import Alamofire
import RxSwift

enum ApiRouter: URLRequestConvertible {
    
    case getNews(searchString: String, page: Int)
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkConstants.BASEURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .getNews:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getNews:
            return "everything"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getNews(let searchString, let page):
            return ["q": searchString,
                    "apiKey": NetworkConstants.APIKEY,
                    "page": page,
                    "pageSize": 20]
        }
    }
}
