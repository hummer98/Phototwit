//
//  TweetListViewController.swift
//  TweetKouga
//
//  Created by Yuji Yamamoto on 2018/06/15.
//  Copyright © 2018年 ridgeroot. All rights reserved.
//

import UIKit
import Instantiate
import InstantiateStandard
import TwitterKit

struct CellData {
    var imageURL: URL
    var tweet: Tweet
}

final class TweetPresenter {
    var tweets: [Tweet] = []
    var data: [CellData] {
        return tweets.flatMap { tweet in
            tweet.imageURLs.compactMap {
                CellData(imageURL: $0, tweet: tweet)
            }
        }
    }
    func cellData(at indexPath: IndexPath) -> CellData {
        return data[indexPath.row]
    }
    func fetch() {
        TwitterManager.getHomeTimeline { [weak self] result in
            self?.tweets = result
        }
    }
}

final class TweetListViewController: TKViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var presenter = TweetPresenter()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    private func refresh() {
        presenter.fetch()
    }
}

extension TweetListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = presenter.cellData(at: indexPath)
        return TweetCell.dequeue(from: tableView, for: indexPath, with: cellData)
    }
}

extension TweetListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension TweetListViewController: StoryboardInstantiatable {}
