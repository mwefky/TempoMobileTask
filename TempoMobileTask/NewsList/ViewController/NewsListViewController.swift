//
//  ViewController.swift
//  TempoMobileTask
//
//  Created by mina wefky on 17/06/2021.
//

import UIKit
import RxSwift

class NewsListViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - variables
    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20))
    var newsViewModel = NewsViewModel()
    var disoseBag = DisposeBag()
    var newsCellIdentifier = "NewsTableViewCell"
    var articles = [Article]() {
        didSet {
            tableView.reloadData()
        }
    }
    var pageCounter = 1
    var isFetching = false
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    // MARK: - binding View Model
    func bindViewModel() {
        newsViewModel.newsSubject.subscribe { newsList in
            self.handleArticles(newsList: newsList)
            self.isFetching = false
        } onError: { _ in
            self.isFetching = false
        }.disposed(by: disoseBag)
    }
    
    // MARK: - UI setup
    func setupUI() {
        // nav bar
        searchBar.placeholder = "Enter search keyword"
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        let search = UIImage(named: "SearchArrow")?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: search, style: .plain, target: self, action: #selector(searchBtnTapped))
        searchBar.delegate = self
        // table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UINib(nibName: newsCellIdentifier, bundle: nil), forCellReuseIdentifier: newsCellIdentifier)
    }
    
    // MARK: - Actions
    @objc func searchBtnTapped() {
        isFetching = true
        articles.removeAll()
        pageCounter = 1
        newsViewModel.fetchNews(with: searchBar.text ?? "", page: pageCounter)
    }
    
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBtnTapped()
        searchBar.resignFirstResponder()
    }
    
    func handleArticles(newsList: NewsModel) {
        articles += newsList.articles
    }
    
    func navigateToNewPage(article: Article) {
        let newsDetailsVC =  NewsDetailsViewController.loadFromNib()
        newsDetailsVC.article = article
        self.navigationController?.pushViewController(newsDetailsVC, animated: true)
    }
}

extension NewsListViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: newsCellIdentifier) as! NewsTableViewCell
        cell.article = articles[indexPath.row]
        return cell
        // swiftlint:enable force_cast
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == articles.count - 1 {
                pageCounter += 1
            if !isFetching {
                self.isFetching = true
                self.newsViewModel.fetchNews(with: searchBar.text ?? "", page: pageCounter)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigateToNewPage(article: articles[indexPath.row])
    }
}
