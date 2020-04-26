//
//  Utilities.swift
//  StarWars
//

import Foundation
import UIKit

class Utilities {
  static func gradient(frame: CGRect, firstColor: UIColor, secondColor: UIColor) -> CAGradientLayer {
    let layer = CAGradientLayer()
    layer.frame = frame
    layer.startPoint = CGPoint(x: 0,y: 0.5)
    layer.endPoint = CGPoint(x: 1,y: 0.5)
    layer.colors = [ firstColor.cgColor, secondColor.cgColor]
    return layer
  }
  
  static func getQueryStringParameter(url stringURL: String?, param: String) -> String? {
    guard let stringURL = stringURL, let url = URLComponents(string: stringURL) else { return nil }
    return url.queryItems?.first(where: { $0.name == param })?.value
  }
  
  static let defaultHeroImage: UIImage? = UIImage.init(named: "defaultImage.jpg") ?? nil
}
