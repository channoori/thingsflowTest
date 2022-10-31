//
//  ImageBannerTableViewCell.swift
//  ThingsflowTest
//
//  Created by Channoori Park on 2022/10/28.
//

import UIKit
import SnapKit
import Kingfisher

class ImageBannerTableViewCell: UITableViewCell {
    static let identifier: String = "ImageBannerTableViewCell"
    
    lazy var imageBannerView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure() {
        setInit()
        if let url = URL(string: "https://s3.ap-northeast-2.amazonaws.com/hellobot-kr-test/image/main_logo.png") {
            imageBannerView.kf.setImage(with: url)
        }
    }
    
    func setInit() {
        self.contentView.addSubview(imageBannerView)
        
        imageBannerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
