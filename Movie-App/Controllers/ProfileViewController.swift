//
//  ProfileViewController.swift
//  Movie-App
//
//  Created by ebpearls on 6/7/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let accountData = AccountData()
    
    var avat: Avatar?
    var movieDB: ImgPath?
    
    let imgView: UIImageView = {
        let image = UIImage(named: "noImage")
        let imgView = UIImageView(image: image)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.borderColor = UIColor.red.cgColor
        imgView.layer.borderWidth = 3
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    func makeCircularImageView() {
        imgView.layer.cornerRadius = imgView.frame.size.width / 2
        imgView.layer.masksToBounds = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeCircularImageView()
    }
    
    let nameLabel: UILabel = {
        let title = UILabel()
        title.adjustsFontSizeToFitWidth = true
        title.numberOfLines = 2
        title.minimumScaleFactor = 0.5
        title.textColor = .black
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 25, weight: .heavy)
        title.text = "Name"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let actualNameLabel: UILabel = {
        let title = UILabel()
        title.adjustsFontSizeToFitWidth = true
        title.numberOfLines = 2
        title.minimumScaleFactor = 0.5
        title.textColor = .black
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 20, weight: .medium)
        title.text = "John Doe"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let usernameLabel: UILabel = {
        let title = UILabel()
        title.adjustsFontSizeToFitWidth = true
        title.numberOfLines = 2
        title.minimumScaleFactor = 0.5
        title.textColor = .black
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 25, weight: .heavy)
        title.text = "Username"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let actualUsernameLabel: UILabel = {
        let title = UILabel()
        title.adjustsFontSizeToFitWidth = true
        title.numberOfLines = 2
        title.minimumScaleFactor = 0.5
        title.textColor = .black
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 20, weight: .medium)
        title.text = "user_name"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    
    
    let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        getAccountDetails()
    }
    
    private func setupUI() {
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(actualNameLabel)
        labelsStackView.addArrangedSubview(usernameLabel)
        labelsStackView.addArrangedSubview(actualUsernameLabel)
        
        
        view.addSubview(imgView)
        view.addSubview(labelsStackView)
        NSLayoutConstraint.activate([
            imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgView.widthAnchor.constraint(equalToConstant: 150),
            imgView.heightAnchor.constraint(equalToConstant: 150),
            imgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            
            // Stack View
            labelsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelsStackView.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 70),
            labelsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        ])
    }
}
    
extension ProfileViewController {
    func getAccountDetails() {
        accountData.getAccountDetail { [weak self] accData in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.actualNameLabel.text = accData.name
                self.actualUsernameLabel.text = accData.username
            }
            avat = accData.avatar
            movieDB = self.avat?.tmdb
            if let url = URL(string: "https://image.tmdb.org/t/p/w185\(String(describing: movieDB!.avatarPath))"){
                DispatchQueue.main.async {
                    self.imgView.kf.setImage(with: url)
                }
            }
        } inComplete: { [weak self] error in
            guard let self = self else {return}
            
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
        }
        
        
    }
}
    

