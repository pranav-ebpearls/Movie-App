//
//  CustomCell.swift
//  Movie-App
//
//  Created by ebpearls on 6/5/24.
//

import UIKit
import Kingfisher

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
        title.adjustsFontSizeToFitWidth = true
        title.numberOfLines = 2
        title.minimumScaleFactor = 0.5
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
            movieImage.heightAnchor.constraint(equalToConstant: 160),
            
            movieTitleLabel.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 5),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    
    
    func configure(with movie: Movie) {
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath)"){
            DispatchQueue.main.async {
                self.movieImage.kf.setImage(with: url)
            }
        }
        movieTitleLabel.text = movie.title
    }
}





