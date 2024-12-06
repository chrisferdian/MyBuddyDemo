//
//  FirebaseStorageRepository.swift
//  MyBuddyDemo
//
//  Created by Indo Teknologi Utama on 05/12/24.
//
import UIKit

protocol FirebaseStorageRepository {
    func uploadImage(_ image: UIImage, completion: @escaping (Result<URL, Error>) -> Void)
    func fetchImageURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void)
}
