//
//  GitMainController.swift
//  GitApp
//
//  Created by BrainX 3096 on 19/08/2022.
//

import Foundation
import Alamofire
import ObjectMapper
extension GitMainController {
    func loadData() {
        AF.request(EndPoints.urlString).responseJSON { response in
            switch (response.result) {
            case let .success(data):
                let tempData = data as! [Any]
                self.gitResponse = Mapper<GitApiResponse>().mapArray(JSONObject:tempData) ?? []
            case .failure:
                print("error")
            }
            self.gitMainScreen.gitListView.reloadData()
        }
    }
}
