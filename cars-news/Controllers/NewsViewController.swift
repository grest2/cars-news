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
        newsView.initialize(image: self.selected?.image, title: self.selected?.title ?? "Неизвестная новость", body: self.selected?.body ?? "Данные об этой новости еще не прогрузились...", date: self.selected?.publishedDate ?? "Сегодня", fullUrl: "https://www.autodoc.ru/", category: "Неизвестная категория")
    }
}
