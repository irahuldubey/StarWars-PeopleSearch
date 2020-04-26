//
//  DetailsViewController.swift
//  StarWars
//

import UIKit

class DetailsViewController: UIViewController {
  
  // Container Views
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var detailView: UIView!
  
  // Label Details
  @IBOutlet weak var activityControl: UIActivityIndicatorView!
  @IBOutlet weak var charName: UILabel!
  @IBOutlet weak var birthYear: UILabel!
  @IBOutlet weak var height: UILabel!
  @IBOutlet weak var mass: UILabel!
  @IBOutlet weak var gender: UILabel!
  @IBOutlet weak var hairColor: UILabel!
  @IBOutlet weak var skinColor: UILabel!
  
  var peopleObject: People?
  private var viewModel: DetailViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = DetailViewModel(withAPI: SWWebService())
    setImageViewGradient()
    setDetailViewGradient()
    
    populateDetailView()
    
    loadHeroImage()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  private func setImageViewGradient() {
    let view = UIView(frame: CGRect.init(x: 0, y: 0, width: imageView.frame.width, height: imageView.frame.height))
    let gradient = CAGradientLayer()
    gradient.frame = view.frame
    gradient.colors = [UIColor.clear.cgColor, UIColor.darkGray.cgColor]
    gradient.locations = [0.0, 1.0]
    view.layer.insertSublayer(gradient, at: 0)
    imageView.addSubview(view)
    imageView.bringSubviewToFront(view)
  }
  
  private func setDetailViewGradient() {
    let viewGradient = UIView(frame: CGRect.init(x: 0, y: 0, width: detailView.frame.width, height: detailView.frame.height))
     let gradientView = CAGradientLayer()
     gradientView.frame = viewGradient.frame
     gradientView.colors = [UIColor.clear.cgColor, UIColor.red.cgColor]
     gradientView.locations = [0.0, 1.0]
     viewGradient.layer.insertSublayer(gradientView, at: 0)
     detailView.addSubview(viewGradient)
     detailView.bringSubviewToFront(viewGradient)
  }
  
  private func populateDetailView() {
    self.charName.text = peopleObject?.name.capitalized
    self.birthYear.text = peopleObject?.birthYear.capitalized
    self.height.text = peopleObject?.height.capitalized
    self.mass.text = peopleObject?.mass.capitalized
    self.gender.text = peopleObject?.gender.capitalized
    self.hairColor.text = peopleObject?.hairColor.capitalized
    self.skinColor.text = peopleObject?.skinColor.capitalized
  }
  
  private func loadHeroImage() {
    activityControl.startAnimating()
    viewModel.fetchImage(with: peopleObject) { [weak self] (image) in
      guard let strongSelf = self else { return }
      DispatchQueue.main.async {
        strongSelf.activityControl.stopAnimating()
        strongSelf.imageView.image = image == nil ? Utilities.defaultHeroImage : image
      }
    }
  }
}
