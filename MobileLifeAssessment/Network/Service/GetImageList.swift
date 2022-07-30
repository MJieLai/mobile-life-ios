//
//  GetImageList.swift
//  MobileLifeAssessment
//
//  Created by MJ on 30/07/2022.
//

import Foundation
import Alamofire

extension APIService {
    func getImageList(page: Int, completionHandler: @escaping (Result<GetImageListResponse, Error>) -> Void) {
        
        let getImageListUrl = "https://picsum.photos/v2/list?page=\(page)&limit=30"
        
        let urlString: String = getImageListUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completionHandler(.failure(APIServiceError.invalidUrl))
            }
            return
        }
        
        APIService.publicRequest(url: url, method: .get, parameters: nil, headers: HTTPHeaders.jsonHeader()) { (response) in
            switch response {
            case .success(let data):
                if let response: GetImageListResponse = try? JSONDecoder().decode(GetImageListResponse.self, from: data) {
                    DispatchQueue.main.async {
                        completionHandler(.success(response))
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(APIServiceError.unexpectedError))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
}

