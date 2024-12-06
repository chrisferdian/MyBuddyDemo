//
//  FirebaseStorageRepositoryImpl.swift
//  MyBuddyDemo
//
//  Created by Indo Teknologi Utama on 05/12/24.
//

import UIKit
import FirebaseStorage

class FirebaseStorageRepositoryImpl: FirebaseStorageRepository {
    private let storage: Storage

    init(storage: Storage = Storage.storage()) {
        self.storage = storage
    }

    func uploadImage(_ image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "InvalidImageData", code: -1, userInfo: nil)))
            return
        }

        let fileName = UUID().uuidString
        let storageRef = storage.reference().child("\(fileName).png")
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                if let url = url {
                    completion(.success(url))
                } else {
                    completion(.failure(NSError(domain: "URLNotFound", code: -2, userInfo: nil)))
                }
            }
        }
    }

    func fetchImageURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let storageRef = storage.reference().child(path)

        storageRef.downloadURL { url, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let url = url {
                completion(.success(url))
            } else {
                completion(.failure(NSError(domain: "URLNotFound", code: -2, userInfo: nil)))
            }
        }
    }
}
