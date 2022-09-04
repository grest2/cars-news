//
//  NewsViewController.swift
//  cars-news
//
//  Created by iOS Developer on 9/2/22.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var goBack: UIImageView!
    @IBOutlet weak var newsView: NewsView!
    
    var selected: NewsViewInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpGoBack()
        
        newsView.initialize(image: self.selected?.image,
                            title: self.selected?.title ?? "Неизвестная новость",
                            body: self.selected?.body ?? "Данные об этой новости еще не прогрузились...",
                            date: self.selected?.publishedDate ?? "Сегодня",
                            fullUrl: self.selected?.fullUrl ?? "https://www.autodoc.ru/",
                            category: self.selected?.category ?? "Неизвестная категория")
        
        self.view.bringSubviewToFront(self.goBack)
    }
    
    // MARK: private methods
    /// Go back view setup
    private func setUpGoBack() {
        self.goBack.isUserInteractionEnabled = true
        self.goBack.tintColor = Colors.newsCellShadow.color
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.goBackAction))
        self.goBack.addGestureRecognizer(gesture)
    }
    
    /// Binding go action for go back icon
    @objc private func goBackAction() {
        self.goBack.tappingAnimation {
            self.dismiss(animated: true)
        }
    }
}
