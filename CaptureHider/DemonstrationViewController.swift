//
//  DemonstrationViewController.swift
//  CaptureHider
//
//  Created by Serena (Antoine) on 01/06/2024.
//

import UIKit

class DemonstrationViewController: UIViewController {

    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupImageViewAndToggle()
    }
    
    func setupImageViewAndToggle() {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(hideFromScreenCaptureToggleClicked(sender:)), for: .valueChanged)
        
        let label = UILabel()
        label.text = "Hide image from Screen Capture"
        
        // stack view to put the label and toggle side-by-side
        let stackView = UIStackView(arrangedSubviews: [label, toggle])
		stackView.spacing = 3
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView = UIImageView(image: .nature)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
		
		/* ignore this label, it's just for demonstration purposes */
		let noticeLabel = UILabel()
		noticeLabel.text = "NOTICE: NO MATTER THE STATE OF THE TOGGLE\nTHE IMAGE WILL ALWAYS BE VISIBLE ON THE USER'S SCREEN"
		noticeLabel.translatesAutoresizingMaskIntoConstraints = false
		noticeLabel.numberOfLines = -1
		noticeLabel.textColor = .secondaryLabel
		noticeLabel.font = .italicSystemFont(ofSize: 12)
		view.addSubview(noticeLabel)
        
        NSLayoutConstraint.activate([
            // place stackView in center
            stackView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -100),
            
            imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            // place imageView below the stackView
            imageView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            imageView.heightAnchor.constraint(equalToConstant: 300),
			
			// noticeLabel below imageView
			noticeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
			noticeLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
			
			noticeLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
			noticeLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    @objc func hideFromScreenCaptureToggleClicked(sender: UISwitch) {
        let result = imageView.hideViewFromCapture(hide: sender.isOn)
        print("did succeed: \(result)")
    }
}
