//
//  CompactVC.swift
//  TestSparrow
//
//  Created by Pasha Otverchenko on 13.05.2023.
//

import UIKit

final class CompactVC: UIViewController {
    
    // MARK: - UI Elements -
    
    private var segmentedControl: UISegmentedControl!
    private var closeButton: UIButton!
    
    // MARK: - Lifecycle -
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        configureSegmentedControl()
        configureButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentedControl.selectedSegmentIndex = 0
    }
    
    // MARK: - Objc Methods -
    
    @objc
    private func segmentedValueDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            preferredContentSize = CGSize(width: 300, height: 280)
        case 1:
            preferredContentSize = CGSize(width: 300, height: 150)
        default:
            break
        }
    }
    
    // MARK: - UI Configuration -
    
    private func configureSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["280pt", "150pt"])
        
        segmentedControl.addTarget(self, action: #selector(segmentedValueDidChange), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.gray()
        let image = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
        config.image = image
        config.baseForegroundColor = .lightGray
        config.baseBackgroundColor = .clear
        closeButton = UIButton(configuration: config, primaryAction: UIAction(handler: { _ in
            self.dismiss(animated: true)
        }))
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: segmentedControl.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }
}
