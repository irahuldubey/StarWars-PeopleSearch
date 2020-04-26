//
//  ViewController.swift
//  StarWars
//

import UIKit

class HomeViewController: UITableViewController, ActivityIndicatorProtocol {
  
  private var homeViewModel: HomeViewModel!
  var activityIndicator = UIActivityIndicatorView()
  private var resources: Resource?
  private var people = [People]()
  
  lazy var searchController: UISearchController  = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = Message.searchPlaceholder
    searchController.searchBar.delegate = self
    return searchController
  }()
  
  lazy var messageLabel: UILabel = {
    let rect = CGRect(x: 0, y: 0, width: tableView.bounds.size.width,
                      height: tableView.bounds.size.height)
    let welcomeMessageLabel: UILabel = UILabel(frame: rect)
    welcomeMessageLabel.text = Message.beginSearch
    welcomeMessageLabel.font = UIFont.init(name: "StarJediRounded", size: 20.0)
    welcomeMessageLabel.textColor = .black
    welcomeMessageLabel.textAlignment = .center
    return welcomeMessageLabel
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    homeViewModel = HomeViewModel(withAPI: SWWebService())
    setUpNavigationAndSearchBar()
  }
  
  private func setUpNavigationAndSearchBar() {
    navigationItem.searchController = searchController
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    definesPresentationContext = true
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: NavigationItemIdentifier.clear,
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(clearSearchResults))
  }
  
  private func show(alert message: String) {
    let alert = UIAlertController.init(title: Message.alert, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction.init(title: Message.ok, style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Button Action
    @objc private func clearSearchResults() {
    people = []
    resources = nil
    tableView.reloadData()
    searchController.searchBar.text = nil
    searchController.searchBar.resignFirstResponder()
  }
  
  // MARK - Deinitializer
  deinit {
    print("Denitialized HomeViewController")
  }
}

// MARK: - Table view Data Source & Delegate

extension HomeViewController {

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    if people.count > 0 {
      self.tableView.backgroundView = nil
      self.tableView.separatorStyle = .singleLine
      return 1
    }
    self.tableView.backgroundView = messageLabel
    self.tableView.separatorStyle = .none
    return 0
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.layer.insertSublayer(Utilities.gradient(frame: cell.bounds,
                                                 firstColor: .green,
                                                 secondColor: .red),
                                                 at:0)
    cell.backgroundColor = .clear
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection
    section: Int) -> String? {
    let totalCount = resources?.count ?? 0
    return "Total characters \(totalCount)"
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.searchResultsCell, for: indexPath) as! HomeViewCell
    let object = people[indexPath.row]
    let rowNumber = String(indexPath.row + 1)
    cell.setUp(number: rowNumber, people: object)
    return cell
  }
  
  // MARK: - Table view delegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: SegueIdentifiers.detail, sender: people[indexPath.row])
  }
}

// MARK: - UISearchBarDelegate Delegate

extension HomeViewController:  UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    showLoadingIndicator(withSize: CGSize.init(width: 80, height: 80))
    guard let text = searchBar.text else {
      return
    }
    firstLoadSearchResults(text: text)
  }
}

// Fetch Search Results
extension HomeViewController {
  
  func firstLoadSearchResults(text: String) {
    homeViewModel.fetchResults(for: text) { [weak self] (resource, error) in
      guard let strongSelf = self else { return }
      DispatchQueue.main.async {
        strongSelf.removeLoadingIndicator()
        if let localResource =  resource, let results = localResource.results {
          strongSelf.resources = localResource
          strongSelf.people = results
          strongSelf.tableView.reloadData()
        } else {
          strongSelf.messageLabel.text = error
        }
      }
    }
  }
  
  func loadNextSearchResults() {
    guard let localResource = resources,
      let _ = localResource.next,
      people.count > 0 else {
      print("No more results to load, that's all what you got !!")
      return
    }
    homeViewModel.loadNextResults { [weak self] (people) in
      guard let strongSelf = self else { return }
      print("Loaded next batch of: \(people.count) characters")
      DispatchQueue.main.async {
        if people.count > 0 {
          strongSelf.people.append(contentsOf: people)
        }
        strongSelf.tableView.reloadData()
      }
    }
  }
}

// MARK: - Scroll View Delegate
extension HomeViewController {
  
  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
      loadNextSearchResults()
    }
  }
}

// MARK: - Navigation
extension HomeViewController {
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let segueId = segue.identifier else {
      return
    }
    switch segueId {
    case SegueIdentifiers.detail:
      if let detailViewController = segue.destination as? DetailsViewController {
        detailViewController.peopleObject = sender as? People
      }
    default:
      break
    }
  }
}
