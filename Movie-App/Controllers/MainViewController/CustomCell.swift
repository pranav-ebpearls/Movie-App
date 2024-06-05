//
//  CustomCell.swift
//  Movie-App
//
//  Created by ebpearls on 6/5/24.
//

import UIKit

class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    let movieImage: UIImageView = {
        let image = UIImage(named: "batman-poster")
        let imgView = UIImageView(image: image)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let movieTitleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 18, weight: .medium)
        title.text = "Movie Title"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(movieImage)
        contentView.addSubview(movieTitleLabel)
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            movieImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImage.widthAnchor.constraint(equalToConstant: 100),
            movieImage.heightAnchor.constraint(equalToConstant: 200),
            
            movieTitleLabel.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 25),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    func configure(with movie: Movie) {
        movieTitleLabel.text = movie.originalTitle
//        movieImage.image = contents.image
    }
}





