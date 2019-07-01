//
//  SwipingCollectionViewCellCell.swift
//  AutoLayoutProgrammatically
//
//  Created by Matheus Oliveira Costa on 29/06/19.
//  Copyright © 2019 Matheus Oliveira Costa. All rights reserved.
//

import UIKit

final class SwipingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var viewModel: SwipingCollectionViewCellViewModel! {
        didSet {
            self.bearImageView.image = self.viewModel.image
            
            let attributedText = NSMutableAttributedString(string: self.viewModel.headline, attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)
            ])
            attributedText.append(NSAttributedString(string: "\n\n\(self.viewModel.text)", attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                NSAttributedString.Key.foregroundColor: UIColor.gray
            ]))
            self.descriptionTextView.attributedText = attributedText
            self.descriptionTextView.textAlignment = .center
        }
    }
    
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
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
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
    }
    
    func setupAdditionalConfiguration() {}
    
}
