//
//  ViewController.swift
//  TurkeyNews
//
//  Created by Hakkı Can Şengönül on 6.03.2024.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGreen
        let endPoint = Endpoint.fetchGetNewsData(queryItems: [.init(name: "country", value: "tr"), .init(name: "tag", value: "general")])
    }


}

