//
//  APIFunctions.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 13/07/2023.
//

import Foundation
import UIKit
import CryptoKit
extension UIViewController{
    
    func fetchDataFromAPI(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }

    func decodeData<T: Decodable>(data: Data, into type: T.Type) -> Result<T, Error> {
        do {
            let decodedData = try JSONDecoder().decode(type, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
    
    
    //MARK: - JWT Token
    func generateRandomKey() -> String? {
        let byteCount = 32 // 256 bits for HMAC-SHA256
        var keyData = Data(count: byteCount)
        let result = keyData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, byteCount, $0.baseAddress!)
        }
        guard result == errSecSuccess else {
            return nil
        }
        let key = keyData.base64EncodedString()
        return key
    }
    
//    func generateJWTToken(username: String?) -> String? {
//        // Specify your JWT token signing key
//        let signingKey = "YOUR_SIGNING_KEY"
//
//        // Create the JWT claims
//        let claims = ["username": username ?? ""]
//        
//        // Create a JWT token using the signing key and claims
//        do {
//            let jwtToken = try JWT.encode(claims: claims, algorithm: .hs256(signingKey.data(using: .utf8)!))
//            return jwtToken
//        } catch {
//            print("Error generating JWT token: \(error.localizedDescription)")
//            return nil
//        }
//    }
    
}
