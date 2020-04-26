//
//  HomeViewcell.swift
//  StarWars
//

import Foundation
import UIKit

class HomeViewCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var creationDateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func setUp(number: String, people: People) {
    DispatchQueue.main.async {
      self.titleLabel.text = "\(number) : \(people.name)"
      self.creationDateLabel.text = DateFormattingHelper.formatDate(date: people.created)
    }
  }

  //MARK: - Deinitializer
  
  deinit {
    print("Deinitialized HomeViewCell")
  }
}
