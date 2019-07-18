//
//  PhotoDetailViewController.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import UIKit

class PhotoDetailViewController: BaseViewController {
    
    private var imageView: UIImageView!
    private var activityIndicator: UIActivityIndicatorView!
    private var cameraLabel: UILabel!
    private var titleLabel: UILabel!
    private var floatButton: UIImageView!
    public var photos: [Photo]?
    public var currentImage: Int = 0
    
    override init() {
        super.init()
        self.photos = [Photo]()
        self.currentImage = 0
        setupUI()
    }
    
    init(photos: [Photo], currentImage: Int) {
        super.init()
        self.currentImage = currentImage
        self.photos = photos
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private func setupUI() {
        view.backgroundColor = Colors.primary
        setupImageView()
        setupLoading()
        setupFloatButton()
        setupCameraLabel()
        setupTitleLabel()
        setupSwipe()
        updateImage()
    }
    
    private func setupImageView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: view.topAnchor, multiplier: 30).isActive = true
        imageView.bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: view.bottomAnchor, multiplier: 30).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8).isActive = true
    }
    
    private func setupLoading() {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupFloatButton() {
        floatButton = UIImageView()
        floatButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floatButton)
        floatButton.layer.cornerRadius = 0.5 * floatButton.bounds.size.width
        
        floatButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        floatButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        floatButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        floatButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        floatButton.isUserInteractionEnabled = true
        floatButton.image = UIImage(named: "ShareThis")
        floatButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didShareButtonPressed)))
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: cameraLabel.topAnchor, constant: -16).isActive = true
        titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: floatButton.leadingAnchor, constant: 8).isActive = true

        titleLabel.text = photos?[currentImage].title ?? "Title"
    }
    
    private func setupCameraLabel() {
        cameraLabel = UILabel()
        cameraLabel.translatesAutoresizingMaskIntoConstraints = false
        cameraLabel.textColor = .white
        view.addSubview(cameraLabel)
        
        cameraLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        cameraLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        
        cameraLabel.text = photos?[currentImage].camera ?? "Camera"
    }
    
    private func setupSwipe() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc private func didShareButtonPressed() {
        guard let url = photos?[currentImage].imageUrl else { return }
        let shareViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(shareViewController, animated: true)
    }
    
    @objc private func didSwipeGesture(gesture: UIGestureRecognizer) {
        //Animations should be improved
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            guard let photosCount = photos?.count else { return }
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                if currentImage == photosCount - 1 {
                    currentImage = 0
                } else {
                    currentImage += 1
                }
            case UISwipeGestureRecognizer.Direction.right:
                if currentImage == 0 {
                    currentImage = photosCount - 1
                } else {
                    currentImage -= 1
                }
            default:
                break
            }
            updateImage()
        }
    }
    
    private func updateImage() {
        
        guard let photo = photos?[currentImage],
            let urlString = photo.imageUrl,
            let url = URL(string: urlString) else { return }
        activityIndicator.startAnimating()
        imageView.sd_setImage(with: url) { (_, _, _, _) in
            self.activityIndicator.stopAnimating()
        }
    }
}
