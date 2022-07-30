//
//  GetImageDetail.swift
//  MobileLifeAssessment
//
//  Created by MJ on 30/07/2022.
//

import Foundation
import Alamofire

extension APIService {
    func getImageDetail(imageId: Int, completionHandler: @escaping (Result<GetImageDetailResponse, Error>) -> Void) {
        
        let getImageDetailUrl = "https://picsum.photos/id/\(imageId)/info"
        
        let urlString: String = getImageDetailUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completionHandler(.failure(APIServiceError.invalidUrl))
            }
            return
        }
        
        APIService.publicRequest(url: url, method: .get, parameters: nil, headers: HTTPHeaders.jsonHeader()) { (response) in
            switch response {
            case .success(let data):
                if let response: GetImageDetailResponse = try? JSONDecoder().decode(GetImageDetailResponse.self, from: data) {
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
