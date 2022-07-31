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
    @IBOutlet weak var phototImageView: UIImageView!
    
    //* MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupView(imageUrl: String) {
        phototImageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "placeholder"))
    }

}
