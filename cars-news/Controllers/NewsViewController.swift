//
//  NewsViewController.swift
//  cars-news
//
//  Created by iOS Developer on 9/2/22.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var newsView: NewsView!
    
    var selected: NewsViewInfo?
    
    override func viewDidLoad() {
        newsView.initialize(image: self.selected?.image, title: self.selected?.title ?? "Test", body: self.selected?.body ?? "Test")
    }
}
