//
//  HttpNetworkError.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation

struct HttpNetworkError: Error {
    let reason: String?
    let httpStatusCode: Int?
    let requestUrl: URL?
    let requestBody: String?
    let serverResponse: String?

    init(withResponse response: Data? = nil, requestUrl url: URL?, body: Data? = nil,  message: String,  statusCode: Int?)
    {
        self.serverResponse = response != nil ? String(data: response!, encoding: .utf8) : nil
        self.requestUrl = url
        self.requestBody = body != nil ? String(data: body!, encoding: .utf8) : nil
        self.httpStatusCode = statusCode
        self.reason = message
    }
}
