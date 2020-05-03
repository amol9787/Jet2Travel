//
//  ViewController.swift
//  Jet2Travel
//
//  Created by MCB-Air-036 on 02/05/20.
//  Copyright © 2020 Amol Deshmukh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    var viewModel = ArticleViewModel()
    var tableArray : [ArticleModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Articles"
        self.showData()
    }

    func showData() {
        indicatorView.startAnimating()
        viewModel.loadArticleData(completion: { response_ArticleModel in
            if let responseModel = response_ArticleModel {
                DispatchQueue.main.async {
                    self.indicatorView.stopAnimating()
                    self.tableArray = responseModel
                    self.articleTableView?.reloadData()
                }
            }
        })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCellIdentifier", for: indexPath) as! ArticleTableViewCell
        cell.setData(article: tableArray?[indexPath.row])
        return cell
    }
}
