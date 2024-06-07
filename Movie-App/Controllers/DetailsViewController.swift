//
//  DetailsViewController.swift
//  Movie-App
//
//  Created by ebpearls on 6/7/24.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    let movieData = MovieData()
    
    var spokenLanguage: [Language] = []
    
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
        imgView.layer.cornerRadius = 30
        imgView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        imgView.layer.borderWidth = 3
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let runtimeLabel: UILabel = {
        let runtime = UILabel()
        runtime.textColor = .black
        runtime.textAlignment = .center
        runtime.font = .systemFont(ofSize: 16, weight: .light)
        runtime.text = "Length"
        runtime.translatesAutoresizingMaskIntoConstraints = false
        return runtime
    }()
    
    let actualRuntimeLabel: UILabel = {
        let runtime = UILabel()
        runtime.textColor = .black
        runtime.textAlignment = .center
        runtime.backgroundColor = UIColor(red: 0.7, green: 0.9, blue: 1.0, alpha: 1.0)
        runtime.font = .systemFont(ofSize: 16, weight: .light)
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
        language.font = .systemFont(ofSize: 16, weight: .light)
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
        language.font = .systemFont(ofSize: 16, weight: .light)
        language.text = "Language"
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
        detailLabel.font = .systemFont(ofSize: 18, weight: .light)
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
    
//    let collectionView: UICollectionView {
//        let collectionView = UICollectionView( frame: <#T##CGRect#>, collectionViewLayout: <#T##UICollectionViewLayout#>)
//    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .white
        setupUI()
        getMovieDetails()
    }
    

        
    func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(imgView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(runtimeLabel)
        scrollView.addSubview(languageLabel)
        scrollView.addSubview(actualRuntimeLabel)
        scrollView.addSubview(actualLanguageLabel)
        scrollView.addSubview(overviewLabel)
        
        
                
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imgView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imgView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.65),
            imgView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
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
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor)
        ])
    }
    
    private var movieId: Int
    
    init (movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension DetailsViewController {
    func getMovieDetails() {
        movieData.getMovieDetail(movieId: movieId) { [weak self] movieDetailResult in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.navigationController?.title = movieDetailResult.title
                self.titleLabel.text = movieDetailResult.title
                self.descriptionLabel.text = movieDetailResult.overview
                self.actualRuntimeLabel.text = "\(movieDetailResult.runtime) min"
                self.spokenLanguage = movieDetailResult.spokenLanguages
                for mo in self.spokenLanguage {
                    self.actualLanguageLabel.text = "\(mo.englishName)"
                }
                
//                convert array into string
//                component separator
//                
//                "Nepali, English, Germany"
            }
            if let url = URL(string: "https://image.tmdb.org/t/p/original\(movieDetailResult.posterPath)"){
                DispatchQueue.main.async {
                    self.imgView.kf.setImage(with: url)
                }
            }
            
        } notSuccessful: { [weak self] error in
            guard let self = self else {return}
            
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
        }
    }
    
}

