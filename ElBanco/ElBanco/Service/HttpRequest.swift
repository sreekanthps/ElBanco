//
//  HttpRequest.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation

protocol Request {
    var url: URL { get set}
    var method: HTTPMethods{get set}
}

struct HttpRequest: Request {
    var url: URL
    var method: HTTPMethods
    var requestBody: Data?
   
    init(withUrl url: URL, requestType type: HTTPMethods, requestBody: Data? = nil){
        self.url = url
        self.method = type
        self.requestBody = requestBody
    }
    
}
