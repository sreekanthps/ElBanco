//
//  DataValidatorModel.swift
//  ElBanco
//
//  Created by Sreekanth on 2/10/21.
//

import Foundation

struct DataModel: Decodable {
    let componentName,validation,errorMessage,rightIcon,placeHolder : String?
    let minLength, maxLength: Int?
    let rightIconRequired: Bool
    
}
