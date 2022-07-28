//
//  ViewController.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import UIKit

class ViewController: UIViewController {
    
    private let newsViewModel: NewsViewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newsViewModel.fetch()
    }
}

