//
//  ProfileScreen.swift
//  Movie-App
//
//  Created by ebpearls on 6/10/24.
//

import UIKit

class ProfileScreen: UIView {

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(actualNameLabel)
        labelsStackView.addArrangedSubview(usernameLabel)
        labelsStackView.addArrangedSubview(actualUsernameLabel)
        
        addSubview(imgView)
        addSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
            imgView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imgView.widthAnchor.constraint(equalToConstant: 150),
            imgView.heightAnchor.constraint(equalToConstant: 150),
            imgView.topAnchor.constraint(equalTo: topAnchor, constant: 110),
            
            labelsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelsStackView.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 70),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
        ])
    }

}
