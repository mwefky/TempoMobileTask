//
//  NewsDetailsViewController.swift
//  TempoMobileTask
//
//  Created by mina wefky on 19/06/2021.
//

import UIKit
import SDWebImage
import WebKit

class NewsDetailsViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    // MARK: - variables
    var article: Article? {
        didSet {
            self.title = article?.title
        }
    }
    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedUI()
//        loadWebView()
    }
    
    func feedUI() {
        self.articleImage.sd_setImage(with: URL(string: article?.urlToImage ?? ""), completed: nil)
        self.title = article?.title
        self.dateLabel.text = "Date: \(article?.publishedAt ?? "")"
        self.sourceLabel.text = "source: \(article?.source.name ?? "")"
        self.authorLabel.text = "author: \(article?.author ?? "")"
        self.descriptionLabel.text = "Description: \(article?.articleDescription ?? "")"
        self.contentLabel.text = "content: \(article?.content ?? "")"
    }
    
    func loadWebView() {
        
    }
    
    @IBAction func navigateToSource(_ sender: Any) {
        guard let urlString = article?.url else { return }
        webView.navigationDelegate = self
        view = webView
        let url = URL(string: urlString)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
