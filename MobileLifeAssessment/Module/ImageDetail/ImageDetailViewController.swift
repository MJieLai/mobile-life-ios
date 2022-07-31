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
    
    @IBOutlet weak var blurSliderWrapView: UIView!
    @IBOutlet weak var blurTitleLabel: UILabel!
    @IBOutlet weak var blurValueLabel: UILabel!
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
    var currentBlurValue: Float = 1
    
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
        blurSliderWrapView.isHidden = (sender.selectedSegmentIndex != 1)
        
        switch sender.selectedSegmentIndex {
        case 0: ///Normal
            self.displayImage(filter: "")
        case 1: ///Blur
            self.displayImage(filter: "?blur=\(currentBlurValue)")
        case 2: ///Grayscale
            self.displayImage(filter: "?grayscale")
        default: break
        }
    }
    
    @objc private func sliderChanged(_ sender: UISlider) {
        let sliderValue = sender.value
        currentBlurValue = sliderValue
        
        blurValueLabel.text = String(format: "%.2f", sliderValue)
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
        blurSliderWrapView.isHidden = true
        blurTitleLabel.font = UIFont.systemFont(ofSize: 15)
        blurTitleLabel.textColor = UIColor.darkGray
        blurTitleLabel.text = "Amount of Blur:"
        blurValueLabel.font = UIFont.systemFont(ofSize: 13)
        blurValueLabel.textColor = UIColor.systemGray
        blurValueLabel.text = "\(currentBlurValue)"
        
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
        let spinner = self.showLoader(view: self.view)
        photoImageView.kf.setImage(with: URL(string: imageItem.download_url + filter), completionHandler: { result in
            spinner.dismissLoader()
            switch result {
            case .success(let value):
                self.photoImageView.image = value.image
            case .failure(_):
                self.photoImageView.image = UIImage(named: "placeholder")
            }
        })
    }
    
    func displayInfo() {
        imageIdLabel.text = imageItem.id
        authorLabel.text = imageItem.author
        sizingLabel.text = "\(imageItem.width) x \(imageItem.height)"
    }
}
