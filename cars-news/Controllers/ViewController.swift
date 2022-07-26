//
//  ViewController.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import UIKit

class ViewController: UIViewController {

    private let requestManager: RequestManaging = DependencyContainer.resolve()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task(priority: .background) {
            let news = try? await self.requestManager.fetchItems(type: News.self)
        }
        
    }


}

