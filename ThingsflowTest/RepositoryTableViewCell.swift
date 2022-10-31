//
//  RepositoryTableViewCell.swift
//  ThingsflowTest
//
//  Created by Channoori Park on 2022/10/28.
//

import UIKit
import SnapKit
import Kingfisher

class RepositoryTableViewCell: UITableViewCell {
    static let idenftifier: String = "RepositoryTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ info: Repository) {
        setInit()
        self.accessoryType = .disclosureIndicator
        titleLabel.text = "#\(info.number ?? 0) - \(info.title ?? "")"
    }
    
    func setInit() {
        self.contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.trailing.bottom.equalToSuperview()
        }
    }

}
