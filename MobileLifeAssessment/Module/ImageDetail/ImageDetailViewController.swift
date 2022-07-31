//
//  ImageDetailViewController.swift
//  MobileLifeAssessment
//
//  Created by MJ on 30/07/2022.
//

import UIKit
import RxSwift

class ImageDetailViewController: UIViewController {
    
    //* MARK: - IBOutlet
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var blurSlider: UISlider!
    
    @IBOutlet weak var imageIdTitleLabel: UILabel!
    @IBOutlet weak var imageIdLabel: UILabel!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sizingTitleLabel: UILabel!
    @IBOutlet weak var sizingLabel: UILabel!
    
    /// Variables
    var viewModel: ImageDetailViewModel!
    let apiService = APIService()
    
    var imageItem: ImageItem!
    
    private let disposeBag = DisposeBag()
    
    //* MARK: -  LifeCycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ImageDetailViewModel(apiService: apiService, parentViewController: self)
        
        configureViews()
        setupObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        
    }
    
    //* MARK: - Helper
    /// Set up view
    func configureViews() {
        self.navigationItem.title = "Photo Details"
        self.setupUI()
        self.displayImage(filter: "")
        self.displayInfo()
        
        segmentControl.addTarget(self, action: #selector(self.segmentSelected(_ :)), for: .valueChanged)
        blurSlider.addTarget(self, action: #selector(self.sliderChanged(_ :)), for: .valueChanged)
    }
    
    func setupObserver() {
    }
    
    @objc private func segmentSelected(_ sender: UISegmentedControl) {
        /// Only show slider when it is under Blur segment
        blurSlider.isHidden = (sender.selectedSegmentIndex != 1)
        
        switch sender.selectedSegmentIndex {
        case 0: ///Normal
            self.displayImage(filter: "")
        case 1: ///Blur
            self.displayImage(filter: "?blur=1")
        case 2: ///Grayscale
            self.displayImage(filter: "?grayscale")
        default: break
        }
    }
    
    @objc private func sliderChanged(_ sender: UISlider) {
        let sliderValue = sender.value
        self.displayImage(filter: "?blur=\(sliderValue)")
    }
}

extension ImageDetailViewController {
    func setupUI() {
        segmentControl.setTitle("Normal".localized(), forSegmentAt: 0)
        segmentControl.setTitle("Blur".localized(), forSegmentAt: 1)
        segmentControl.setTitle("Grayscale".localized(), forSegmentAt: 2)
        
        blurSlider.isContinuous = false
        blurSlider.minimumValue = 1
        blurSlider.maximumValue = 10
        blurSlider.isHidden = true
        
        imageIdTitleLabel.font = UIFont.systemFont(ofSize: 15)
        imageIdTitleLabel.textColor = UIColor.darkGray
        imageIdTitleLabel.text = "Image ID:"
        imageIdLabel.font = UIFont.systemFont(ofSize: 13)
        imageIdLabel.textColor = UIColor.systemGray
        
        authorTitleLabel.font = UIFont.systemFont(ofSize: 15)
        authorTitleLabel.textColor = UIColor.darkGray
        authorTitleLabel.text = "Author:"
        authorLabel.font = UIFont.systemFont(ofSize: 13)
        authorLabel.textColor = UIColor.systemGray
        
        sizingTitleLabel.font = UIFont.systemFont(ofSize: 15)
        sizingTitleLabel.textColor = UIColor.darkGray
        sizingTitleLabel.text = "Size:"
        sizingLabel.font = UIFont.systemFont(ofSize: 13)
        sizingLabel.textColor = UIColor.systemGray
    }
    
    func displayImage(filter: String) {
        photoImageView.kf.setImage(with: URL(string: imageItem.download_url + filter), placeholder: UIImage(named: "placeholder"))
        print(imageItem.download_url + filter)
    }
    
    func displayInfo() {
        imageIdLabel.text = imageItem.id
        authorLabel.text = imageItem.author
        sizingLabel.text = "\(imageItem.width) x \(imageItem.height)"
    }
}
