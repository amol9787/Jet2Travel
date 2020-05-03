//
//  ArticleViewModel.swift
//  Jet2Travel
//
//  Created by MCB-Air-036 on 02/05/20.
//  Copyright © 2020 Amol Deshmukh. All rights reserved.
//

import UIKit

class ArticleViewModel {

    func loadArticleData(completion: @escaping([ArticleModel]?)-> Void) {

        let urlStr = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=1&limit=10"

        NetworkAPIManager().getResponse(for: urlStr, completion: {(result) in

            if let reposneObject = result {
                let responseModelObject = try! JSONDecoder().decode([ArticleModel].self, from: reposneObject)
                completion(responseModelObject)
            }

        })
    }

}
