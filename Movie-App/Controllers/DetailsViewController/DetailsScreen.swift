//
//  DetailsScreen.swift
//  Movie-App
//
//  Created by ebpearls on 6/10/24.
//

import UIKit

class DetailsScreen: UIView {

    let scrollView: UIScrollView = {
        let scollView = UIScrollView()
        scollView.translatesAutoresizingMaskIntoConstraints = false
        return scollView
    }()
    
    let imgView: UIImageView = {
        let image = UIImage(named: "noImage")
        let imgView = UIImageView(image: image)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 35
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = 20
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let runtimeLabel: UILabel = {
        let runtime = UILabel()
        runtime.textColor = .black
        runtime.textAlignment = .center
        if let customFont = UIFont(name: "Calibri", size: 20) {
            runtime.font = customFont
        }
        runtime.text = "Length"
        runtime.translatesAutoresizingMaskIntoConstraints = false
        return runtime
    }()
    
    let actualRuntimeLabel: UILabel = {
        let runtime = UILabel()
        runtime.textColor = .black
        runtime.textAlignment = .center
        runtime.backgroundColor = UIColor(red: 0.7, green: 0.9, blue: 1.0, alpha: 1.0)
        if let customFont = UIFont(name: "Calibri", size: 20) {
            runtime.font = customFont
        }
        runtime.clipsToBounds = true
        runtime.text = "Length"
        runtime.translatesAutoresizingMaskIntoConstraints = false
        runtime.layer.cornerRadius = 10
        return runtime
    }()
    
    let languageLabel: UILabel = {
        let language = UILabel()
        language.textColor = .black
        language.textAlignment = .center
        if let customFont = UIFont(name: "Calibri", size: 20) {
            language.font = customFont
        }
        language.text = "Language"
        language.translatesAutoresizingMaskIntoConstraints = false
        return language
    }()
    
    let actualLanguageLabel: UILabel = {
        let language = UILabel()
        language.textColor = .black
        language.textAlignment = .center
        language.backgroundColor = UIColor(red: 0.7, green: 0.9, blue: 1.0, alpha: 1.0)
        language.clipsToBounds = true
        if let customFont = UIFont(name: "Calibri", size: 20) {
            language.font = customFont
        }
        language.layer.cornerRadius = 10
        language.translatesAutoresizingMaskIntoConstraints = false
        return language
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.adjustsFontSizeToFitWidth = true
        title.numberOfLines = 2
        title.minimumScaleFactor = 0.5
        title.textColor = .black
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 30, weight: .heavy)
        title.text = "Movie Title"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let descriptionLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.adjustsFontSizeToFitWidth = true
        detailLabel.numberOfLines = 50
        detailLabel.minimumScaleFactor = 0.5
        detailLabel.textColor = .black
        detailLabel.textAlignment = .justified
        if let customFont = UIFont(name: "Calibri", size: 20) {
            detailLabel.font = customFont
        }
        detailLabel.text = "Movie Description"
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        return detailLabel
    }()
    
    let overviewLabel: UILabel = {
        let runtime = UILabel()
        runtime.textColor = .black
        runtime.textAlignment = .left
        runtime.font = .systemFont(ofSize: 25, weight: .semibold)
        runtime.text = "Description"
        runtime.translatesAutoresizingMaskIntoConstraints = false
        return runtime
    }()
    
    let castLabel: UILabel = {
        let runtime = UILabel()
        runtime.textColor = .black
        runtime.textAlignment = .left
        runtime.font = .systemFont(ofSize: 25, weight: .semibold)
        runtime.text = "Cast"
        runtime.translatesAutoresizingMaskIntoConstraints = false
        return runtime
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(imgView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(runtimeLabel)
        scrollView.addSubview(languageLabel)
        scrollView.addSubview(actualRuntimeLabel)
        scrollView.addSubview(actualLanguageLabel)
        scrollView.addSubview(overviewLabel)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(castLabel)
        
                
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imgView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imgView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.65),
            imgView.widthAnchor.constraint(equalTo: widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            
            runtimeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            runtimeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            runtimeLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -300),
            
            actualRuntimeLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: 2),
            actualRuntimeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 18),
            actualRuntimeLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -300),
            
            languageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            languageLabel.leadingAnchor.constraint(equalTo: runtimeLabel.trailingAnchor, constant: 15),
            languageLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -185),
            
            actualLanguageLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 2),
            actualLanguageLabel.leadingAnchor.constraint(equalTo: actualRuntimeLabel.trailingAnchor, constant: 15),
            actualLanguageLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -185),
            
            overviewLabel.topAnchor.constraint(equalTo: actualRuntimeLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            overviewLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            
            descriptionLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            
            castLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            castLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            castLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            
            collectionView.heightAnchor.constraint(equalToConstant: 150),
            collectionView.widthAnchor.constraint(equalToConstant: 380),
            collectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            collectionView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor)
        ])
    }
    
    func configure(with movie: MovieDetail) {
        if let url = URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath)"){
            DispatchQueue.main.async {
                self.imgView.kf.setImage(with: url)
            }
        }
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
    }

}
