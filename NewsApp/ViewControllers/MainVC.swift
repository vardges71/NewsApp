//
//  ViewController.swift
//  NewsApp
//
//  Created by Vardges Gasparyan on 2021-09-29.
//

import UIKit
import RealmSwift

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var response = [NewsModel]()
    var choosedNews: NewsModel?
    let realm = try! Realm()
    
    var searchResult: String? = nil
    
    var myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    private let mainView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private let searchView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private let searchContainer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 4.0
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 4.0
        return view
    }()
    
    private let searchIcon: UIButton = {
        
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(searchBtnTapped),
                         for: .touchUpInside)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = UIColor.init(red: 90/255, green: 0/255, blue: 15/255, alpha: 1)
        return button
    }()
    
    private let searchTF: UITextField = {
        
        let textfield = MyTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.attributedPlaceholder = NSAttributedString(string: "Search for a news...", attributes: [.foregroundColor: UIColor.init(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.5), .font: UIFont.systemFont(ofSize: 13)])
        textfield.textColor = UIColor.init(red: 90/255, green: 0/255, blue: 15/255, alpha: 1)
        textfield.keyboardType = .default
        textfield.autocapitalizationType = .none
        textfield.returnKeyType = UIReturnKeyType.search
        return textfield
    }()
    
    private let homeTableView: UITableView = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeTVCell")
        return table
    }()
    
    private let bottomView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private let goToFavoritesBtn: UIButton = {
        
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(goToFavoritesBtnTapped),
                         for: .touchUpInside)
//        button.setImage(UIImage(systemName: "arrow.down.right.square"), for: .normal)
        button.setTitle("FAVORITES", for: .normal)
        button.tintColor = UIColor.init(red: 90/255, green: 0/255, blue: 15/255, alpha: 1)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
        homeTableView.dataSource = self
        homeTableView.delegate = self
        
        UserDefaults.standard.removeObject(forKey: "phrasesToSearch")
        
        if response.isEmpty {
            NewsManager().fetchNewsJson(mainVC: self)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Keyboard shift View
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y = 0
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height / keyboardSize.height)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchBtnTapped()
        return true
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func setupElements() {
        
        view.backgroundColor = .systemBackground
        
        myActivityIndicator.center = view.center
        myActivityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        myActivityIndicator.layer.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7).cgColor
        myActivityIndicator.color = .white
        
        let loadingTextLabel = UILabel()
        loadingTextLabel.textColor = UIColor.white
        loadingTextLabel.text = "Loading..."
        loadingTextLabel.font = UIFont.boldSystemFont(ofSize: 19)
        loadingTextLabel.sizeToFit()
        loadingTextLabel.center = CGPoint(x: myActivityIndicator.center.x, y: myActivityIndicator.center.y + 50)
        myActivityIndicator.addSubview(loadingTextLabel)
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        self.view.addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        self.mainView.addSubview(searchView)
        searchView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        searchView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        searchView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.12).isActive = true
        searchView.backgroundColor = .clear
        
        self.searchView.addSubview(searchContainer)
        searchContainer.centerXAnchor.constraint(equalTo: searchView.centerXAnchor).isActive = true
        searchContainer.widthAnchor.constraint(equalTo: searchView.widthAnchor, multiplier: 0.9).isActive = true
        searchContainer.centerYAnchor.constraint(equalTo: searchView.centerYAnchor, constant: 5).isActive = true
        searchContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.searchContainer.addSubview(searchIcon)
        searchIcon.topAnchor.constraint(equalTo: searchContainer.topAnchor).isActive = true
        searchIcon.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor, constant: 8).isActive = true
        searchIcon.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor).isActive = true
        searchIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        searchIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.searchContainer.addSubview(searchTF)
        searchTF.topAnchor.constraint(equalTo: searchContainer.topAnchor).isActive = true
        searchTF.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor).isActive = true
        searchTF.trailingAnchor.constraint(equalTo: searchContainer.trailingAnchor).isActive = true
        searchTF.bottomAnchor.constraint(equalTo: searchContainer.bottomAnchor).isActive = true
        searchTF.text = ""
        
        self.mainView.addSubview(homeTableView)
        homeTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor).isActive = true
        homeTableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        homeTableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        homeTableView.backgroundColor = .clear
        
        self.mainView.addSubview(bottomView)
        bottomView.topAnchor.constraint(equalTo: homeTableView.bottomAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.1).isActive = true
        
        self.bottomView.addSubview(goToFavoritesBtn)
        Styles.styleFilledButton(goToFavoritesBtn)
        goToFavoritesBtn.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16).isActive = true
        goToFavoritesBtn.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -16).isActive = true
        goToFavoritesBtn.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16).isActive = true
        goToFavoritesBtn.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.3).isActive = true
        goToFavoritesBtn.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.5).isActive = true
        
        myActivityIndicator.superview?.bringSubviewToFront(myActivityIndicator)
        homeTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return response.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTVCell", for: indexPath) as! HomeTableViewCell
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
        
        cell.favoriteButton.addTarget(self, action: #selector(favoriteBtnTapped(sender:)), for: .touchUpInside)
        
        myActivityIndicator.stopAnimating()
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
    
    public func processData(res: [NewsModel]) {
        
        self.response = res
        DispatchQueue.main.async { self.homeTableView.reloadData() }
    }
    
    @objc func searchBtnTapped() {
        
        myActivityIndicator.startAnimating()
        
        if (searchTF.text == "") {
            
            UserDefaults.standard.removeObject(forKey: "phrasesToSearch")
            
        } else {
            
            searchResult = (searchTF.text)?.replacingOccurrences(of: " ", with: "")
            UserDefaults.standard.set(searchResult, forKey: "phrasesToSearch")
        }
        
        NewsManager().fetchNewsJson(mainVC: self)
        
        myActivityIndicator.startAnimating()
    }
    
    @objc func favoriteBtnTapped(sender: UIButton) {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: homeTableView)
        let indexPath: IndexPath = homeTableView.indexPathForRow(at: buttonPosition)!
        
        let currentNews = response[indexPath.row]
        
        try! realm.write {
            realm.add(currentNews)
        }
        
        let image = UIImage(systemName: "star.fill")
        sender.setImage(image, for: .normal)
        
    }
    
    @objc func goToFavoritesBtnTapped() {
        
        let toFavoritesVC = FavVC()
        let navVC = UINavigationController(rootViewController: toFavoritesVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
}

extension MainVC {
    
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        mainView.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        mainView.endEditing(false)
    }
}
