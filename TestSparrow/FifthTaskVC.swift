//
//  ViewController.swift
//  TestSparrow
//
//  Created by Pasha Otverchenko on 05.05.2023.
//

import UIKit

final class FifthTaskVC: UIViewController, UIPopoverPresentationControllerDelegate {
    
    // MARK: - UI Elements -
    
    private var button: UIButton!
        
    // MARK: - Fields -
        
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureButton()
    }
    
    // MARK: - Objective-C Methods -
    
    @objc
    private func handlePresentingVC() {
        let vc = CompactVC()
        vc.preferredContentSize = CGSize(width: 300, height: 280)
        vc.modalPresentationStyle = .popover
        if let pres = vc.presentationController {
            pres.delegate = self
        }
        present(vc, animated: true)
        
        if let pop = vc.popoverPresentationController {
            pop.delegate = self
            pop.sourceView = button
            pop.sourceRect = button.bounds
            pop.permittedArrowDirections = .up
        }
    }
    
    // MARK: - Popover Delegate -
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: - UI Configuration -
    
    private func configureButton() {
        var config = UIButton.Configuration.gray()
        config.baseForegroundColor = .systemPink
        config.title = "Present"
        
        button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(handlePresentingVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ])
    }
}

