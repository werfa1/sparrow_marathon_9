//
//  ViewController.swift
//  TestSparrow
//
//  Created by Pasha Otverchenko on 05.05.2023.
//

import UIKit

final class SecondTaskVC: UIViewController {
    
    // MARK: - UI Elements -
    
    private var firstButton : UIButton!
    private var secondButton: UIButton!
    private var thirdButton : UIButton!
    
    private var configuration : UIButton.Configuration!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.tintAdjustmentMode = .automatic
        
        configuration = setupConfig()
        configureFirstButton()
        configureSecondButton()
        configureThirdButton()
    }
    
    // MARK: - Objective-C Methods -
    
    @objc
    private func handleShowingModalVC(_ sender: UIButton) {
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [.allowUserInteraction, .beginFromCurrentState],
            animations: {
                sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: [.beginFromCurrentState, .allowUserInteraction]) {
                    sender.transform = CGAffineTransform.identity
                }
        })
        if sender.tag == 3 {
            let modalVC = UIViewController()
//            if let sheet = modalVC.sheetPresentationController {
//                sheet.largestUndimmedDetentIdentifier = .large
//            }
            modalVC.view.backgroundColor = .systemMint
            present(modalVC, animated: true)
        }
    }
    
    // MARK: - UI Configuration -
    
    private func setupConfig() -> UIButton.Configuration {
        
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .trailing
        config.automaticallyUpdateForSelection = false
        config.image = UIImage(systemName: "arrow.right.circle.fill")?.withRenderingMode(.alwaysTemplate)
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        config.imagePadding = 8
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.background.backgroundColor = .systemBlue
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var i = incoming
            i.foregroundColor = .white
            return i
        }
        
        config.imageColorTransformer = UIConfigurationColorTransformer({ _ in
            return .white
        })
        
        return config
    }
    
    private func configureFirstButton() {
        configuration.title = "First Button"
        firstButton = SparrowButton(configuration: configuration)
        firstButton.tag = 1
        firstButton.tintAdjustmentMode = .automatic
        firstButton.addTarget(self, action: #selector(handleShowingModalVC), for: .touchUpInside)
        view.addSubview(firstButton)
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120)
        ])
    }
    
    private func configureSecondButton() {
        configuration.title = "Second medium Button"
        secondButton = SparrowButton(configuration: configuration)
        secondButton.tag = 2
        secondButton.addTarget(self, action: #selector(handleShowingModalVC), for: .touchUpInside)
        view.addSubview(secondButton)
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func configureThirdButton() {
        configuration.title = "Third"
        thirdButton = SparrowButton(configuration: configuration)
        thirdButton.tag = 3
        thirdButton.addTarget(self, action: #selector(handleShowingModalVC), for: .touchUpInside)
        view.addSubview(thirdButton)
        thirdButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 20)
        ])
    }
}

final class SparrowButton: UIButton {
    override func tintColorDidChange() {
        super.tintColorDidChange()
        switch tintAdjustmentMode {
        case .dimmed :
            configuration?.background.backgroundColor = .gray
        default:
            configuration?.background.backgroundColor = .systemBlue
        }
    }
}

