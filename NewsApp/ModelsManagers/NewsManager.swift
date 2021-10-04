//
//  NewsManager.swift
//  NewsApp
//
//  Created by Vardges Gasparyan on 2021-09-30.
//

import Foundation
import RealmSwift

class NewsManager {
    
    var source: String = ""
    var author: String = ""
    var title: String = ""
    var newsDescription: String = ""
    var image_url: String = ""
    var news_url: String = ""
//    var publishedAt: Date?
    var content: String = ""
    
    static let mainVC = MainVC()
    static let favVC = FavVC()
    public var publishedNews: [NewsModel] = []
    let realm = try! Realm()
    
    let apiKey = "752b1f7c04e44f0dbb89d15f2df58bf5"
    let searchResult = UserDefaults.standard.object(forKey: "phrasesToSearch")
    var about: String?
    
//    var a: String?
    
    func fetchNewsJson(mainVC: MainVC) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://newsapi.org/v2/everything?q=\(searchResult ?? String(describing: about))&sortBy=publishedAt&apiKey=\(apiKey)")! as URL)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
                
                print(error!)
            } else {
                
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse ?? "Not available")
                
                do {
                    
                    let dict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                    
                    if let results = dict["articles"] as? Array<Dictionary<String, Any>> {
                        for result in results {
                            
                            let oneNews = NewsModel()
                            
                            if let newsTitle = result["title"] as? String {
                                oneNews.title = newsTitle
                            }
                            if let newsAuthor = result["author"] as? String {
                                oneNews.author = newsAuthor
                            }
                            if let newsDescription = result["description"] as? String {
                                oneNews.newsDescription = newsDescription
                            }
                            if let newsImageUrl = result["urlToImage"] as? String {
                                oneNews.image_url = newsImageUrl
                            }
                            if let newsUrl = result["url"] as? String {
                                oneNews.news_url = newsUrl
                            }
                            if let newsSourceResultes = result["source"] as? Dictionary<String, Any> {
                                
                                for (key, value) in newsSourceResultes {
                                    if key == "name" {
                                        oneNews.source = value as? String ?? ""
                                    }
                                }
                            }
                            
                            self.publishedNews.append(oneNews)
                        }
                        mainVC.processData(res: self.publishedNews)
                    }
                } catch {
                    print("json error: \(error)")
                }
            }
        })
        dataTask.resume()
    }
    
    func fetchFavorites(favVC: FavVC) {
        
        let news = realm.objects(NewsModel.self)
        
        for new in news {
            
            let oneFavNews = NewsModel()
            
            if let newsTitle = new.title as? String {
                oneFavNews.title = newsTitle
            }
            if let newsAuthor = new.author as? String {
                oneFavNews.author = newsAuthor
            }
            if let newsDescription = new.newsDescription as? String {
                oneFavNews.newsDescription = newsDescription
            }
            if let newsImageUrl = new.image_url as? String {
                oneFavNews.image_url = newsImageUrl
            }
            if let newsUrl = new.news_url as? String {
                oneFavNews.news_url = newsUrl
            }
            if let newsSourceResultes = new.source as? String {
                oneFavNews.source = newsSourceResultes
            }
            
            self.publishedNews.append(oneFavNews)
//            print("EXISTING NEWS: \(new.title)")
        }
        
        favVC.processData(res: self.publishedNews)
    }
}
