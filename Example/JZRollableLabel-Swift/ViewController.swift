//
//  ViewController.swift
//  JZRollableLabel-Swift
//
//  Created by Jiahao Zhu on 12/31/2020.
//  Copyright (c) 2020 jiahao_zhu98@outlook.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "JZRollableLabel - A label control that can roll while displaying infomation."
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Show Examples", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setBackgroundImage(UIImage(named: "buttonBackground"), for: .normal)
        btn.contentMode = .scaleToFill
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(button)
        
        layoutUI()
    }
    
    private func layoutUI() {
        containerView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 20).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -20).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        button.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 50).isActive = true
        button.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -50).isActive = true
        button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    @objc private func btnAction() {
        let vc = ExampleViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

}
