//
//  FirestoreRepository.swift
//  MyBuddyDemo
//

protocol FirestoreRepository {
    associatedtype Model: Codable
    
    func fetchAll(completion: @escaping (Result<[Model], Error>) -> Void)
    func fetch(byID id: String, completion: @escaping (Result<Model, Error>) -> Void)
    func create(_ model: Model, withID id: String, completion: @escaping (Result<Void, Error>) -> Void)
    func update(_ model: Model, withID id: String, completion: @escaping (Result<Void, Error>) -> Void)
    func delete(byID id: String, completion: @escaping (Result<Void, Error>) -> Void)
}
