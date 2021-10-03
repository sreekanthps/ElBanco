//
//  DataValidator+Helper.swift
//  ElBanco
//
//  Created by Sreekanth on 2/10/21.
//

import Foundation

public class DataValidator {
    static let shared = DataValidator()
    var validators: [DataModel]?
    var utility = HttpUtility.shared
    //MARK: Private Initializer
    private init(){
        validators =  utility.readJsonArrayResponse(withName: "dataValidation")
    }
    
     func returnValidator(withName name: String) -> DataModel? {
        return validators?.filter{ $0.componentName == name}.first
    }
    
    func returnValidationReport(withObject object: DataModel, text: String) -> String? {
        if let maxLength = object.maxLength , text.count > maxLength {
            return object.errorMessage
        }
        if let minLength = object.minLength , text.count < minLength {
            return object.errorMessage
        }
        if let regEx = object.validation, !validateRegex(expression: regEx, text: text) {
            return object.errorMessage
        }
        
        return nil
    }
    private func validateRegex(expression: String, text: String) -> Bool {
        do {
               let regex = try NSRegularExpression(pattern: expression)
               let results = regex.matches(in: text, range: NSRange(location: 0, length: text.count))
               if results.count == 0 { return false }
           } catch let error as NSError {
               return false
           }
        return true
    }
}
