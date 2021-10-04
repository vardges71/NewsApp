//
//  HomeTableViewCell.swift
//  NewsApp
//
//  Created by Vardges Gasparyan on 2021-09-29.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    let cellView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true

        return view
    }()
    
    let newsImageView: UIImageView = {
        
        let imgView = UIImageView(image: UIImage(named: "21601"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode  = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.borderColor = UIColor.init(red: 236/255, green: 173/255, blue: 0/255, alpha: 1).cgColor
        imgView.layer.borderWidth = 2.5
        
        return imgView
    }()
    
    let newsTitleLabel: UILabel = {
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 1
        nameLabel.sizeToFit()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.textColor = UIColor.init(red: 90/255, green: 0/255, blue: 15/255, alpha: 1)
        
        nameLabel.text = "HAS NOT BEEN IMPLEMENTED !!! HAS NOT BEEN IMPLEMENTED !!! HAS NOT BEEN IMPLEMENTED !!! HAS NOT BEEN IMPLEMENTED !!!"
        
        return nameLabel
    }()
    
    let newsSourseLabel: UILabel = {
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.sizeToFit()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 9)
        nameLabel.textColor = UIColor.init(red: 90/255, green: 0/255, blue: 15/255, alpha: 0.7)
        
        nameLabel.text = "(No sourse)"
        
        return nameLabel
    }()
    
    let newsDescriptionLabel: UILabel = {
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.sizeToFit()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        nameLabel.textColor = UIColor.init(red: 90/255, green: 0/255, blue: 15/255, alpha: 1)
        
        nameLabel.text = "(NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times NewYork Times)"
        
        return nameLabel
    }()
    
    let newsAuthorLabel: UILabel = {
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 1
        nameLabel.sizeToFit()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 10)
        nameLabel.textColor = UIColor.init(red: 90/255, green: 0/255, blue: 15/255, alpha: 0.7)
        
        nameLabel.text = "Author: Vardges Gasparyan"
        
        return nameLabel
    }()
    
    let favoriteButton: UIButton = {

        let button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = UIColor.init(red: 90/255, green: 0/255, blue: 15/255, alpha: 1)
//        button.addTarget(self, action: #selector(payedButtonTapped), for: .touchUpInside)

        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements() {
        
        self.contentView.addSubview(cellView)
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        self.cellView.addSubview(newsImageView)
        newsImageView.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        newsImageView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
        newsImageView.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.3).isActive = true
        newsImageView.heightAnchor.constraint(equalTo: newsImageView.widthAnchor, multiplier: 0.8).isActive = true
        
        self.cellView.addSubview(newsTitleLabel)
        newsTitleLabel.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 7).isActive = true
        newsTitleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -5).isActive = true
        
        self.cellView.addSubview(newsSourseLabel)
        newsSourseLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor).isActive = true
        newsSourseLabel.leadingAnchor.constraint(equalTo: newsTitleLabel.leadingAnchor).isActive = true
        
        self.cellView.addSubview(newsDescriptionLabel)
        newsDescriptionLabel.topAnchor.constraint(equalTo: newsSourseLabel.bottomAnchor, constant: 3).isActive = true
        newsDescriptionLabel.leadingAnchor.constraint(equalTo: newsTitleLabel.leadingAnchor).isActive = true
        newsDescriptionLabel.widthAnchor.constraint(equalTo: newsTitleLabel.widthAnchor, multiplier: 0.85).isActive = true
        newsDescriptionLabel.heightAnchor.constraint(equalTo: newsImageView.heightAnchor, multiplier: 0.45).isActive = true
        
        self.cellView.addSubview(newsAuthorLabel)
        newsAuthorLabel.topAnchor.constraint(equalTo: newsDescriptionLabel.bottomAnchor, constant: 5).isActive = true
        newsAuthorLabel.leadingAnchor.constraint(equalTo: newsDescriptionLabel.leadingAnchor).isActive = true
        newsAuthorLabel.widthAnchor.constraint(equalTo: newsDescriptionLabel.widthAnchor).isActive = true
        
        self.cellView.addSubview(favoriteButton)
        favoriteButton.bottomAnchor.constraint(equalTo: newsAuthorLabel.bottomAnchor).isActive = true
        favoriteButton.leadingAnchor.constraint(equalTo: newsAuthorLabel.trailingAnchor, constant: 5).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 33).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 33).isActive = true
    }
}
