//
//  SwipingCollectionViewCellCell.swift
//  AutoLayoutProgrammatically
//
//  Created by Matheus Oliveira Costa on 29/06/19.
//  Copyright © 2019 Matheus Oliveira Costa. All rights reserved.
//

import UIKit

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    
    func setupView() {
        self.buildViewHierarchy()
        self.setupConstraints()
        self.setupAdditionalConfiguration()
    }
    
}

final class SwipingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    let topImageContainerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        return containerView
    }()
    
    let bearImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bear_first"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedText = NSMutableAttributedString(string: "Join us today", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)
            ])
        attributedText.append(NSAttributedString(string: "\n\nAre you ready?", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
            NSAttributedString.Key.foregroundColor: UIColor.gray
            ]))
        
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Prev", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .gray
        
        return pc
    }()
    
    lazy var bottomControlsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.previousButton, self.pageControl, self.nextButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - CodeView
extension SwipingCollectionViewCell: CodeView {
    
    func buildViewHierarchy() {
        self.addSubview(self.topImageContainerView)
        self.topImageContainerView.addSubview(self.bearImageView)
        self.addSubview(self.descriptionTextView)
        self.addSubview(self.bottomControlsStackView)
    }
    
    func setupConstraints() {
        self.topImageContainerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.topImageContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.topImageContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.topImageContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        
        self.bearImageView.centerXAnchor.constraint(equalTo: self.topImageContainerView.centerXAnchor).isActive = true
        self.bearImageView.centerYAnchor.constraint(equalTo: self.topImageContainerView.centerYAnchor).isActive = true
        self.bearImageView.heightAnchor.constraint(equalTo: self.topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        self.descriptionTextView.topAnchor.constraint(equalTo: self.topImageContainerView.bottomAnchor).isActive = true
        self.descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        NSLayoutConstraint.activate([
            self.bottomControlsStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.bottomControlsStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.bottomControlsStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupAdditionalConfiguration() {}
    
}
