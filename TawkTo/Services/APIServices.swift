//
//  APIServices.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 11/10/21.
//

import Foundation
import UIKit

class APIServices: NSObject {
    
    static let sharedInstance = APIServices()
    public var authenticationToken : String? = nil
    public var customJsonDecoder : JSONDecoder? = nil
    let BASE_URL = "https://api.github.com/"
    
    fileprivate override init() {
    }
    
    public func request<T:Decodable>(httpRequest: HTTPRequest, resultType: T.Type, completionHandler:@escaping(Result<T?, HTTPNetworkError>)-> Void) {
        switch httpRequest.method {
        case .get:
            getData(requestUrl: httpRequest.url, resultType: resultType) { completionHandler($0)}
            break
            
        case .post:
            postData(request: httpRequest, resultType: resultType) { completionHandler($0)}
            break
        }
    }
    
    // MARK: - Private functions
    private func createJsonDecoder() -> JSONDecoder {
        let decoder =  customJsonDecoder != nil ? customJsonDecoder! : JSONDecoder()
        if(customJsonDecoder == nil) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
    
    private func createUrlRequest(requestUrl: URL) -> URLRequest {
        var urlRequest = URLRequest(url: requestUrl)
        if(authenticationToken != nil) {
            urlRequest.setValue(authenticationToken!, forHTTPHeaderField: "authorization")
        }
        
        return urlRequest
    }
    
    private func decodeJsonResponse<T: Decodable>(data: Data, responseType: T.Type) -> T? {
        let decoder = createJsonDecoder()
        do {
            return try decoder.decode(responseType, from: data)
        }catch let error {
            debugPrint("deocding error =>\(error.localizedDescription)")
        }
        return nil
    }
    
    // MARK: - GET Api
    private func getData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(Result<T?, HTTPNetworkError>)-> Void) {
        var urlRequest = self.createUrlRequest(requestUrl: requestUrl)
        urlRequest.httpMethod = HTTPMethods.get.rawValue
        urlRequest.addValue("luhana.jyoti@gmail.com", forHTTPHeaderField: "email")
        urlRequest.addValue("jyoti@git0105", forHTTPHeaderField: "password")
        
        
        performOperation(requestUrl: urlRequest, responseType: T.self) { (result) in
            completionHandler(result)
        }
    }
    
    // MARK: - POST Api
    private func postData<T:Decodable>(request: HTTPRequest, resultType: T.Type, completionHandler:@escaping(Result<T?, HTTPNetworkError>)-> Void) {
        var urlRequest = self.createUrlRequest(requestUrl: request.url)
        urlRequest.httpMethod = HTTPMethods.post.rawValue
        urlRequest.httpBody = request.requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        performOperation(requestUrl: urlRequest, responseType: T.self) { (result) in
            completionHandler(result)
        }
    }
    
    // MARK: - Perform data task
    private func performOperation<T: Decodable>(requestUrl: URLRequest, responseType: T.Type, completionHandler:@escaping(Result<T?, HTTPNetworkError >) -> Void) {
        URLSession.shared.dataTask(with: requestUrl) { (data, httpUrlResponse, error) in
            
            let statusCode = (httpUrlResponse as? HTTPURLResponse)?.statusCode
            if(error == nil && data != nil && data?.count != 0) {
                let response = self.decodeJsonResponse(data: data!, responseType: responseType)
                if(response != nil) {
                    completionHandler(.success(response))
                }else {
                    completionHandler(.failure(HTTPNetworkError(withServerResponse: data, forRequestUrl: requestUrl.url!, withHttpBody: requestUrl.httpBody, errorMessage: error.debugDescription, forStatusCode: statusCode!)))
                }
            }
            else {
                let networkError = HTTPNetworkError(withServerResponse: data, forRequestUrl: requestUrl.url!, withHttpBody: requestUrl.httpBody, errorMessage: error.debugDescription, forStatusCode: statusCode!)
                completionHandler(.failure(networkError))
            }
            
        }.resume()
    }
    
    //MARK: Fetch data from local json file
    func loadJson<T: Decodable>(filename fileName: String, responseType: T.Type) -> T? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let fileurl = URL(fileURLWithPath: url.path)
                let data = try Data(contentsOf: fileurl)
                let response = self.decodeJsonResponse(data: data, responseType: responseType)
                return response
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
