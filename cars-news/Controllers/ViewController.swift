//
//  ViewController.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import UIKit

class ViewController: UIViewController {
    @Injected()

    private let requestManager: RequestManaging = RequestManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task(priority: .background) {
            let news = try? await self.requestManager.fetchItems(type: News.self)
        }
        
    }


}

