//
//  DateFormatter.swift
//  Climat
//
//  Created by Юлия Кагирова on 24.11.2024.
//

import Foundation

extension String {
    func stringFromDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from:  self) {
            dateFormatter.dateFormat = "HH:mm"
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            return nil
        }
    }
    
    func dayMonthTimeString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from:  self) {
            dateFormatter.dateFormat = "yy-MM-dd H:mm"
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            return nil
        }
    }
}
