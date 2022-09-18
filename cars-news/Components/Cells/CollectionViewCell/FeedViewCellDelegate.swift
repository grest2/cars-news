//
//  FeedViewCellDelegate.swift
//  cars-news
//
//  Created by iOS Developer on 9/17/22.
//

import Foundation

protocol FeedViewCellDelegate: AnyObject {
    func onLongTimePressure(id: Int)
}
