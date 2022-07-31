//
//  ImageListCollectionViewCell.swift
//  MobileLifeAssessment
//
//  Created by MJ on 31/07/2022.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class ImageListCollectionViewCell: UICollectionViewCell {
        
    //* MARK: - IBOutlet
    @IBOutlet weak var photoImageView: UIImageView!
    
    //* MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupView(imageItem: ImageItem) {
        /// Replace width to smaller size
        var modifiedImageUrl = imageItem.download_url.replacingOccurrences(of: "\(imageItem.width)", with: "200")
        /// Replace height to smaller size
        modifiedImageUrl = modifiedImageUrl.replacingOccurrences(of: "\(imageItem.height)", with: "200")
        
        photoImageView.kf.setImage(with: URL(string: modifiedImageUrl), placeholder: UIImage(named: "placeholder"))
    }

}
