//
//  Extension.swift
//  MoviesApp
//
//  Created by Ashwini Apurkar on 10/08/23.
//

import Foundation
import UIKit

extension String {
    
    func convertTime(timeSec: String) -> String {
        let mTime = (Int(timeSec) ?? 0) % (24 * 60)
        let hours = mTime / 60
        let minutes = mTime % 60
        let time = "\(hours)h \(minutes)min"
        return time
    }
    
    func convertDate(dateString : String , currentFormate : String , changeFormateTo : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormate
        let date = dateFormatter.date(from: dateString)!
        dateFormatter.dateFormat = changeFormateTo
        let returnString = dateFormatter.string(from: date)
        return returnString
    }
    
    func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
        let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
        let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
        let range = (self as NSString).range(of: text)
        fullString.addAttributes(boldFontAttribute, range: range)
        return fullString
    }
    
}
