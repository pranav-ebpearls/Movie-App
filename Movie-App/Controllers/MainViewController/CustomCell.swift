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
        let image = UIImage(named: "noImage")
        let imgView = UIImageView(image: image)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 10
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = 5
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
    
    let movieRating: UILabel = {
        let rating = UILabel()
        rating.textColor = .black
        rating.textAlignment = .left
        rating.font = .systemFont(ofSize: 15, weight: .light)
        rating.translatesAutoresizingMaskIntoConstraints = false
        return rating
    }()
    
    let movieLength: UILabel = {
        let length = UILabel()
        length.textColor = .black
        length.textAlignment = .left
        length.font = .systemFont(ofSize: 15, weight: .light)
        length.translatesAutoresizingMaskIntoConstraints = false
        return length
    }()
    
    let genreID1: UILabel = {
        let genre1 = UILabel()
        genre1.textColor = .black
        genre1.textAlignment = .left
        genre1.font = .systemFont(ofSize: 15, weight: .light)
        genre1.translatesAutoresizingMaskIntoConstraints = false
        genre1.text = "horror"
        return genre1
    }()
    
    let genreID2: UILabel = {
        let genre2 = UILabel()
        genre2.textColor = .black
        genre2.textAlignment = .left
        genre2.font = .systemFont(ofSize: 15, weight: .light)
        genre2.text = "horror"
        genre2.translatesAutoresizingMaskIntoConstraints = false
        return genre2
    }()
    
    let genreID3: UILabel = {
        let genre3 = UILabel()
        genre3.textColor = .black
        genre3.textAlignment = .left
        genre3.font = .systemFont(ofSize: 15, weight: .light)
        genre3.text = "horror"
        genre3.translatesAutoresizingMaskIntoConstraints = false
        return genre3
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
        contentView.addSubview(movieRating)
        contentView.addSubview(movieLength)
        contentView.addSubview(genreID1)
        contentView.addSubview(genreID2)
        contentView.addSubview(genreID3)
    
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            movieImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImage.widthAnchor.constraint(equalToConstant: 100),
            movieImage.heightAnchor.constraint(equalToConstant: 155),
            
            movieTitleLabel.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 5),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            movieRating.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 5),
            movieRating.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            movieRating.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            movieLength.topAnchor.constraint(equalTo: movieRating.bottomAnchor, constant: 5),
            movieLength.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            movieLength.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            genreID1.topAnchor.constraint(equalTo: movieLength.bottomAnchor, constant: 5),
            genreID1.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            genreID1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            genreID2.topAnchor.constraint(equalTo: movieRating.bottomAnchor, constant: 5),
            genreID2.leadingAnchor.constraint(equalTo: genreID1.trailingAnchor, constant: 16),
            genreID2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            genreID3.topAnchor.constraint(equalTo: movieRating.bottomAnchor, constant: 5),
            genreID3.leadingAnchor.constraint(equalTo: genreID2.trailingAnchor, constant: 16),
            genreID3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
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
    
    let numberToString = [
        28: "Action",
        12: "Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        14: "Fantasy",
        36: "History",
        27: "Horror",
        10402: "Music",
        9648: "Mystery",
        10749: "Romance",
        878: "Science Fiction",
        10770: "TV Movie",
        53: "Thriller",
        10752: "War",
        37: "Western"
    ]
    
    func configure(with movie: Movie) {
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath)") {
            DispatchQueue.main.async {
                self.movieImage.kf.setImage(with: url)
            }
        }
        movieTitleLabel.text = movie.title
        
        let rating = imageAndLabel(imgName: "star.fill", label: " \(String(format: "%.1f", movie.voteAverage))/10 IMDb")
        movieRating.attributedText = rating
        
        let genre: [Int] = movie.genreIds

        var genreName = [String]()
        
        for number in genre {
            if let string = numberToString[number] {
                genreName.append(string)
            } else {
                genreName.append("Unknown")
            }
        }
        
        var first: String?
        var second: String?
        var third: String?
        
        func assignValues(from array: [String]) {
            if array.indices.contains(0) {
                first = array[0]
            }
            if array.indices.contains(1) {
                second = array[1]
            }
            if array.indices.contains(2) {
                third = array[2]
            }
        }
        
        assignValues(from: genreName)
        
        genreID1.text = first
        genreID2.text = second
        genreID3.text = third
    }
}
