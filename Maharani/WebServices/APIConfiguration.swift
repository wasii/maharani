//
//  APIConfiguration.swift
//  Networking
//
//  Created by A2 MacBook Pro 2012 on 17/06/20.
//  Copyright © 2020 A2 MacBook Pro 2012. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var url: URL { get }
    var parameters: [String: String] { get }
    var headers: HTTPHeaders { get }
}

protocol UploadMediaFilesAPIConfiguration: APIConfiguration {
    var images: [BBMedia] { get set }
    var documents: [BBMedia] { get set }
}


protocol UploadAPIConfiguration: APIConfiguration {
    var images: [String: [UIImage?]] { get set }
    var documents: [String: [Data?]] { get set }
}

protocol KeyValuePairAPIConfiguration: APIConfiguration {
    var keyValues: KeyValuePairs<String, String> { get }
}

extension APIConfiguration {
    var headers: HTTPHeaders {
        var tempHeaders: HTTPHeaders = HTTPHeaders()
        for (field, value) in Constants.headers {
            tempHeaders.add(HTTPHeader(name: field, value: value))
        }
        return tempHeaders
    }
    
    var url: URL {
        let baseURL = URL(string: Constants.baseURL)!
        return baseURL.appendingPathComponent(path)
    }
    
    func asURLRequest() throws -> URLRequest {
        let baseURL = URL(string: Constants.baseURL)!

        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        Constants.headers.forEach { (field, value) in
            urlRequest.addValue(value, forHTTPHeaderField: field)
        }

        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            throw AFError.parameterEncoderFailed(reason: AFError.ParameterEncoderFailureReason.encoderFailed(error: error))
        }

        return urlRequest
    }
}


