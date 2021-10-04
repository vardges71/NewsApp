//
//  FavVC.swift
//  NewsApp
//
//  Created by Vardges Gasparyan on 2021-10-01.
//

import UIKit
import RealmSwift

class FavVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var response = [NewsModel]()
    var choosedNews: NewsModel?
    let realm = try! Realm()
    
    private let favTableView: UITableView = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: "favTVCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
        favTableView.dataSource = self
        favTableView.delegate = self
        
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backTo))
        
        if response.isEmpty {
            NewsManager().fetchFavorites(favVC: self)
            print("EXIST NEWS COUNT: \(response.count)")
        }
    }
    
    func setupElements() {
        
        navigationItem.title = "Favorites"
        
        self.view.addSubview(favTableView)
        favTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        favTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        favTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        favTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        favTableView.backgroundColor = .white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favTVCell", for: indexPath) as! HomeTableViewCell
        
        cell.backgroundColor = .clear
        
        let currentItem = response[indexPath.row]
        
        cell.newsTitleLabel.text = currentItem.title
        cell.newsAuthorLabel.text = "Author: \(currentItem.author)"
        cell.newsDescriptionLabel.text = currentItem.description
        cell.newsSourseLabel.text = "(\(currentItem.source))"
        
        let imageURL = (URL(string: currentItem.image_url) ?? URL(string: "https://google.com"))!
        let imageData = (try? Data(contentsOf: imageURL))
        let image = UIImage(data: imageData ?? Data())
        cell.newsImageView.image = image
        
        cell.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.favoriteButton.addTarget(self, action: #selector(favoriteBtnTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        choosedNews = response[indexPath.row]
        
        let toSingleNewVC = SingleNewVC()
        let navVC = UINavigationController(rootViewController: toSingleNewVC)
        toSingleNewVC.singleNew = choosedNews
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
    @objc func favoriteBtnTapped(sender: UIButton) {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: favTableView)
        let indexPath: IndexPath = favTableView.indexPathForRow(at: buttonPosition)!
        
        let currentNews = response[indexPath.row]
        
        try! realm.write {
            realm.delete(realm.objects(NewsModel.self).filter("title=%@", currentNews.title))
        }
        
        NewsManager().fetchFavorites(favVC: self)
        
        let image = UIImage(systemName: "star")
        sender.setImage(image, for: .normal)
    }
    
    public func processData(res: [NewsModel]) {
        
        self.response = res
        DispatchQueue.main.async { self.favTableView.reloadData() }
    }
    
    @objc private func backTo() {
        dismiss(animated: true, completion: nil)
    }
}
