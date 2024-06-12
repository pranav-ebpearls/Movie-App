//
//  CollectionCell.swift
//  Movie-App
//
//  Created by ebpearls on 6/10/24.
//

import UIKit
import Kingfisher

class CollectionCell: UICollectionViewCell {
    static let identifier = "CollectionCell"
    
    let imageView: UIImageView = {
        let image = UIImage(named: "noImage")
        let imgView = UIImageView(image: image)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 12
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = 5
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.adjustsFontSizeToFitWidth = true
        name.numberOfLines = 5
        name.minimumScaleFactor = 0.5
        name.textColor = .black
        name.textAlignment = .center
        name.font = .systemFont(ofSize: 15, weight: .medium)
        name.text = "John Doe"
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 75),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nameLabel.widthAnchor.constraint(equalToConstant: 75),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func configureWith(with cast: Cast) {
        
        if cast.profilePath == nil {
            imageView.image = UIImage(named: "noImage")

            } else {
                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(cast.profilePath!)") {
                    DispatchQueue.main.async {
                        self.imageView.kf.setImage(with: url)
                    }
            }
        }
        nameLabel.text = cast.name
    }
}
