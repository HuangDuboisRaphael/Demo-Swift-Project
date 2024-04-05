//
//  HomeViewController.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 05/04/2024.
//

import UIKit

class HomeViewController: UIViewController {
    weak var homeCoordinator: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        let button = UIButton(type: .system)
        button.setTitle("Press me", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func buttonPressed() {
        homeCoordinator?.pushToDetailView()
    }
}
