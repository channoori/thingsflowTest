//
//  DetailIssueViewController.swift
//  ThingsflowTest
//
//  Created by Channoori Park on 2022/10/28.
//

import UIKit
import SnapKit
import Kingfisher

class DetailIssueViewController: UIViewController {
    
    let repository: Repository

    let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 15)
        return textView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 1
        return label
    }()
    
    let userStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.backgroundColor = .white
        return stackView
    }()

    init(repository: Repository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "#\(repository.number ?? 0)"
        initUI()
        bodyTextView.text = repository.body ?? ""
        if let url = URL(string: repository.user.avatar_url ?? "") {
            profileImageView.kf.setImage(with: url)
        }
        userNameLabel.text = repository.user.login
    }
    
    func initUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(userStackView)
        self.view.addSubview(bodyTextView)
        
        userStackView.addArrangedSubview(profileImageView)
        userStackView.addArrangedSubview(userNameLabel)
        
        userStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(20)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        
        bodyTextView.snp.makeConstraints { make in
            make.top.equalTo(userStackView.snp.bottom).offset(10)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        profileImageView.layer.cornerRadius = 25
    }
}
