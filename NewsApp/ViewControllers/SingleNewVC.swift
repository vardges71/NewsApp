//
//  SingleNewVC.swift
//  NewsApp
//
//  Created by Vardges Gasparyan on 2021-09-29.
//

import UIKit
import WebKit

class SingleNewVC: UIViewController {
    
    var singleNew: NewsModel?
    
    private let singleNewsView: WKWebView = {
    
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backTo))
        navigationItem.title = singleNew?.source
        
        view.addSubview(singleNewsView)
        
        guard let url = URL(string: singleNew?.news_url ?? "https://google.com") else {return}
        singleNewsView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        singleNewsView.frame = view.bounds
    }
    
    @objc private func backTo() {
        dismiss(animated: true, completion: nil)
    }
}
