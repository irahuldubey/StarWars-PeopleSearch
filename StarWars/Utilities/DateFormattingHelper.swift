//
//  DateFormatter.swift
//  StarWars
//

import Foundation

class DateFormattingHelper {
  
  static func formatDate(date: String) -> String? {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    let dateObj: Date? = dateFormatterGet.date(from: date)
    if let dateObj = dateObj {
      return dateFormatter.string(from: dateObj)
    }
    return nil
  }
}
