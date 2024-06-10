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
        genre2.translatesAutoresizingMaskIntoConstraints = false
        return genre2
    }()
    
    let genreID3: UILabel = {
        let genre3 = UILabel()
        genre3.textColor = .black
        genre3.textAlignment = .left
        genre3.font = .systemFont(ofSize: 15, weight: .light)
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
            genreID3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
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
    
    
    
    func configure(with movie: Movie)  {
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath)"){
            DispatchQueue.main.async {
                self.movieImage.kf.setImage(with: url)
            }
        }
        movieTitleLabel.text = movie.title
        
        let rating = imageAndLabel(imgName: "star.fill", label: " \(String(format: "%.1f", movie.voteAverage))/10 IMDb")
        movieRating.attributedText = rating
        

        
//        print(movie.genreIds)
        
//        var genre: [Int] = movie.genreIds
//        
//        var genreName: [String] = [" "]
//        
//        
//        
//        genreID1.text = genreName[0]
//        genreID2.text = genreName[1]
//        genreID3.text = genreName[2]
//        
//        for i in 0..<genre.count {
//            switch genre[i] {
//            case 28:
//                genreName.append("Action")
//            case 12:
//                genreName.append("Adventure")
//            case 16:
//                genreName.append("Animation")
//            case 35:
//                genreName.append("Comedy")
//            case 80:
//                genreName.append("Crime")
//            case 99:
//                genreName.append("Documentary")
//            case 18:
//                genreName.append("Drama")
//            case 10751:
//                genreName.append("Family")
//            case 14:
//                genreName.append("Fantasy")
//            case 36:
//                genreName.append("History")
//            case 27:
//                genreName.append("Horror")
//            case 10402:
//                genreName.append("Music")
//            case 9648:
//                genreName.append("Mystery")
//            case 10749:
//                genreName.append("Romance")
//            case 878:
//                genreName.append("Science Fiction")
//            case 10770:
//                genreName.append("TV Movie")
//            case 53:
//                genreName.append("Thriller")
//            case 10752:
//                genreName.append("War")
//            case 37:
//                genreName.append("Western")
//            default:
//                genreName.append("Unknown")
//            }
//        }
//        print(genreName)
    }
}





