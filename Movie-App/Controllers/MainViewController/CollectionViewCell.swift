//
//  CollectionViewCell.swift
//  Movie-App
//
//  Created by ebpearls on 6/11/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"

    let poster: UIImageView = {
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
    
    let title: UILabel = {
        let name = UILabel()
        name.adjustsFontSizeToFitWidth = true
        name.numberOfLines = 5
        name.minimumScaleFactor = 0.5
        name.textColor = .black
        name.textAlignment = .left
        name.font = .systemFont(ofSize: 15, weight: .medium)
        name.textAlignment = .center
        name.text = "John Doe"
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let rate: UILabel = {
        let name = UILabel()
        name.adjustsFontSizeToFitWidth = true
        name.numberOfLines = 5
        name.minimumScaleFactor = 0.5
        name.textColor = .black
        name.textAlignment = .left
        name.font = .systemFont(ofSize: 15, weight: .medium)
        name.textAlignment = .center
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
        contentView.addSubview(poster)
        contentView.addSubview(title)
        contentView.addSubview(rate)
        
        NSLayoutConstraint.activate([
            poster.widthAnchor.constraint(equalToConstant: 170),
            poster.heightAnchor.constraint(equalToConstant: 265),
            poster.topAnchor.constraint(equalTo: topAnchor),
            poster.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            title.widthAnchor.constraint(equalToConstant: 180),
            title.topAnchor.constraint(equalTo: poster.bottomAnchor),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            rate.widthAnchor.constraint(equalToConstant: 180),
            rate.topAnchor.constraint(equalTo: title.bottomAnchor),
            rate.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func imageAndLabel (imgName: String, label: String) -> NSMutableAttributedString {
        let image = UIImage(systemName: "\(imgName)")?.withTintColor(.systemYellow)
        let attachment = NSTextAttachment()
        attachment.image = image
        let attachmentSize = CGSize(width: 15, height: 13)
        attachment.bounds = CGRect(origin: .zero, size: attachmentSize)
        let attachmentString = NSAttributedString(attachment: attachment)
        let labelText = NSMutableAttributedString(string: " ")
        labelText.append(attachmentString)
        labelText.append(NSAttributedString(string: "\(label)"))
        return labelText
    }
    
    func apiCall(with movie: Movie) {
        if let url = URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath)") {
            DispatchQueue.main.async {
                self.poster.kf.setImage(with: url)
            }
        }
        title.text = movie.title
        let rating = imageAndLabel(imgName: "star.fill", label: " \(String(format: "%.1f", movie.voteAverage))")
        rate.attributedText = rating
    }
    
}
