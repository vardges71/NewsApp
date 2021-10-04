//
//  NewsModel.swift
//  NewsApp
//
//  Created by Vardges Gasparyan on 2021-09-29.
//

import Foundation
import RealmSwift

public class NewsModel: Object {
    
    @objc dynamic public var source: String = ""
    @objc dynamic public var author: String = ""
    @objc dynamic public var title: String = ""
    @objc dynamic public var newsDescription: String = ""
    @objc dynamic public var image_url: String = ""
    @objc dynamic public var news_url: String = ""
//    var publishedAt: Date?
    
//    init(source: String,
//         author: String,
//         title: String,
//         newsDescription: String,
//         image_url: String,
//         news_url: String) {
//        
//        self.source = source
//        self.author = author
//        self.title = title
//        self.newsDescription = newsDescription
//        self.image_url = image_url
//        self.news_url = news_url
//    }
}
