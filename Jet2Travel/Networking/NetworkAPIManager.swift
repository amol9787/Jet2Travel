//
//  NetworkAPIManager.swift
//  Jet2Travel
//
//  Created by MCB-Air-036 on 02/05/20.
//  Copyright © 2020 Amol Deshmukh. All rights reserved.
//

import UIKit

class NetworkAPIManager: NSObject {

    func getResponse(for urlString:String, completion: @escaping(Data?)->Void) {

        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request){ (data, response, error) in

            guard let json_Data = data else {print("Error"); return}

            guard let jsonString = String(data: json_Data, encoding: String.Encoding.isoLatin1) else { return }

            if let data = jsonString.data(using: .utf8) {
                completion(data)
            }
        }.resume()
    }
    
}
