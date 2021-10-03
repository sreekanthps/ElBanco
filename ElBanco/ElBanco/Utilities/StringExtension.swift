//
//  StringExtension.swift
//  BitBucketList
//
//  Created by  Sreekanth on 3/9/21.
//

import Foundation
extension String {
    var displayStringDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateformmatter
        guard let  date = dateFormatter.date(from: self) else { return self}
        dateFormatter.dateFormat =  Constants.shortstringformatter
        return  dateFormatter.string(from: date)
    }
}
