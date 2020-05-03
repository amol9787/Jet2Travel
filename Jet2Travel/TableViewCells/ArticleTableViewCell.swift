//
//  ArticleTableViewCell.swift
//  Jet2Travel
//
//  Created by MCB-Air-036 on 02/05/20.
//  Copyright © 2020 Amol Deshmukh. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDesignationLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleContentLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleUrlLabel: UILabel!

    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var articleImageViewConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(article:ArticleModel?) {

        // TimeStamp
        if let timeStampString = article?.article_CreatedAtString {
            var getTimeString = String(timeStampString)
            getTimeString.getTimeStampString()
            self.timestampLabel.text = getTimeString
        }

        // User Data
        if let userAvatar = article?.article_UserArray?[0].user_AvatarString {
            self.userImageView.downloadImageFromUrl(String(userAvatar))
        }

        if let userName = article?.article_UserArray?[0].user_NameString {
            self.userNameLabel.text = String(userName)
        }

        if let userDesignation = article?.article_UserArray?[0].user_DesignationString {
            self.userDesignationLabel.text = String(userDesignation)
        }


        // Article Data
        if let mediaImage = article?.article_MediaArray?[0].media_Image {
            articleImageViewConstraint.constant = 160
            self.articleImageView.downloadImageFromUrl(String(mediaImage))
        } else {
            articleImageViewConstraint.constant = 0
        }
        articleImageView.layoutIfNeeded()

        if let articleContent = article?.article_ContentString {
            self.articleContentLabel.text = String(articleContent)
        }

        if let articleTitle = article?.article_MediaArray?[0].media_Title {
            self.articleTitleLabel.text = String(articleTitle)
        }

        if let mediaUrl = article?.article_MediaArray?[0].media_Url {
            self.articleUrlLabel.text = String(mediaUrl)
        }


        // Like/Comment Data
        if let likes = article?.article_LikesCount {
            var likeCount = String(likes)
            likeCount.getFloatString(floatValue: CGFloat(likes))
            self.likeLabel.text = "\(likeCount) Likes"
        }

        if let comments = article?.article_CommentsCount {
            var commentsCount = String(comments)
            commentsCount.getFloatString(floatValue: CGFloat(comments))
            self.commentLabel.text = "\(commentsCount) Comments"
        }
    }
}

extension String {
    mutating func getFloatString(floatValue:CGFloat) {
        let countValue = CGFloat(floatValue) >= 1000.0 ? String(format: "%.1f", CGFloat(floatValue)/1000.0) : String(format: "%.1f", CGFloat(floatValue))

        if floatValue>=1000 {
            self = "\(countValue)K"
        } else {
            self = countValue
        }
    }

    mutating func getTimeStampString() {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        let fetchedDate = dateFormatter.date(from:self)
        print(fetchedDate as Any)

        if let serverDate = fetchedDate?.daysFromToday() {
            self = "\(serverDate) days ago"
        }
    }
}

extension Date {
    func daysFromToday() -> Int {
        return Calendar.current.dateComponents([.day], from: self, to: Date()).day!
    }
}

extension UIImageView {

    func downloadImageFromUrl(_ url: String?) {

        if let urlString = url {
            guard let imageURL = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: imageURL, completionHandler: { [weak self] (data, response, error) -> Void in
                guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200, let mimeType = response?.mimeType, mimeType.hasPrefix("image"), let data = data, error == nil, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.image = image
                }
            }).resume()
        }
    }
}
