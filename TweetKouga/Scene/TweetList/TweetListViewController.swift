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
import RxSwift

struct CellData {
    var imageURL: URL
    var tweet: Tweet
}

final class TweetListViewController: TKViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var tweets: [Tweet] = []
    var data: [CellData] {
        return tweets.flatMap { tweet in
            return tweet.entities.urls.compactMap { string -> CellData? in
                guard let url = URL(string: string) else {
                    return nil
                }
                return CellData(imageURL: url, tweet: tweet)
            }
        }
    }
    
    private let disposeBag = DisposeBag()
    
    func cellData(at indexPath: IndexPath) -> CellData {
        return data[indexPath.row]
    }
    
    private func refresh() {
        
        TwitterManager.getHomeTimeline().subscribe(onSuccess: { (result) in
            self.tweets = result
            self.tableView.reloadData()
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
}
// TODO
// [ ] Placeholder
// [ ] kfのロード終了でリサイズ
extension TweetListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let with = cellData(at: indexPath)
        return TweetCell.dequeue(from: tableView, for: indexPath, with: with)
    }
}

extension TweetListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension TweetListViewController: StoryboardInstantiatable {}
