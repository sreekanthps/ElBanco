//
//  HttpUtility.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation

public class HttpUtility {
    //MARK: Shared Instance
    static let shared = HttpUtility()
    
    //MARK: Properties
    var authToken: String? = nil
    public var customJsonDecoder : JSONDecoder? = nil
    
    //MARK: Private Initializer
    private init(){}
    
     func request<T:Decodable>(request: HttpRequest, resultType: T.Type, completionHandler:@escaping(Result<T?, HttpNetworkError>)-> Void) {
        switch request.method {
        case .GET:
            getData(requestUrl: request.url, resultType: resultType) { completionHandler($0)}
            break
        case .POST:
            postData(request: request, resultType: resultType) { completionHandler($0)}
            break
        }
    }
    
    // MARK: - GET Api
     func getData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(Result<T?, HttpNetworkError>)-> Void) {
        var urlRequest = self.createUrlRequest(requestUrl: requestUrl)
        urlRequest.httpMethod = HTTPMethods.GET.rawValue
        performOperation(requestUrl: urlRequest, responseType: T.self) { (result) in
            completionHandler(result)
        }
    }

    // MARK: - POST Api
     func postData<T:Decodable>(request: HttpRequest, resultType: T.Type, completionHandler:@escaping(Result<T?, HttpNetworkError>)-> Void) {
        var urlRequest = self.createUrlRequest(requestUrl: request.url)
        urlRequest.httpMethod = HTTPMethods.POST.rawValue
        urlRequest.httpBody = request.requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        performOperation(requestUrl: urlRequest, responseType: T.self) { (result) in
            completionHandler(result)
        }
    }
    
    // MARK: - Private functions
    private func createUrlRequest(requestUrl: URL) -> URLRequest {
        var urlRequest = URLRequest(url: requestUrl)
        if let token = authToken {
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }
    
    
    private func createJsonDecoder() -> JSONDecoder {
        let decoder =  customJsonDecoder != nil ? customJsonDecoder! : JSONDecoder()
        if(customJsonDecoder == nil) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
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
    
    // MARK: - Perform data task
    private func performOperation<T: Decodable>(requestUrl: URLRequest, responseType: T.Type, completionHandler:@escaping(Result<T?, HttpNetworkError>) -> Void) {
        URLSession.shared.dataTask(with: requestUrl) { (data, httpUrlResponse, error) in
            let statusCode = (httpUrlResponse as? HTTPURLResponse)?.statusCode
            if(error == nil && data != nil && data?.count != 0) {
                let response = self.decodeJsonResponse(data: data!, responseType: responseType)
                if(response != nil) {
                    completionHandler(.success(response))
                }else {
                    let error = HttpNetworkError(withResponse: data, requestUrl: requestUrl.url, body: requestUrl.httpBody, message: error.debugDescription, statusCode: statusCode!)
                    completionHandler(.failure(error))
                }
            }
            else {
                let error =  HttpNetworkError(withResponse: data, requestUrl: requestUrl.url, body: requestUrl.httpBody, message: error.debugDescription, statusCode: statusCode)
                completionHandler(.failure(error))
            }

        }.resume()
    }
    
    //MARK: Read JSON
    public func readJsonResponse<T: Decodable>(withName name: String) -> T? {
        guard let path = Bundle.main.url(forResource: name, withExtension: "json") else { return nil}
        do {
            let data = try Data(contentsOf: path)
            let response = decodeJsonResponse(data: data, responseType: T.self)
            return response
        }catch let error {
            debugPrint("EB:  readJsonResponse: \(error.localizedDescription)")
        }
        return nil
    }
    
    //MARK: Read JSON
    public func readJsonArrayResponse<T: Decodable>(withName name: String) -> [T]? {
        guard let path = Bundle.main.url(forResource: name, withExtension: "json") else { return nil}
        let decoder = createJsonDecoder()
        do {
            let data = try Data(contentsOf: path)
            let response = try decoder.decode([T].self, from: data)
            return response
        }catch let error {
            debugPrint("EB:  readJsonArrayResponse: \(error.localizedDescription)")
        }
        return nil
    }
}

