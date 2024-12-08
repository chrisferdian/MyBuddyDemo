//
//  FirestoreRepositoryImpl.swift
//  MyBuddyDemo
//
import FirebaseFirestore

class FirestoreRepositoryImpl<Model: Codable>: FirestoreRepository {
    private let collection: CollectionReference
    
    init(collectionPath: String) {
        self.collection = Firestore.firestore().collection(collectionPath)
    }
    
    func fetchAll(completion: @escaping (Result<[Model], Error>) -> Void) {
        collection.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            
            do {
                let models: [Model] = try documents.map { try $0.data(as: Model.self) }
                completion(.success(models))
            } catch {
                print("[FirestoreRepositoryImpl] Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func fetch(byID id: String, completion: @escaping (Result<Model, Error>) -> Void) {
        collection.document(id).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                if let document = document, document.exists {
                    let model = try document.data(as: Model.self)
                    completion(.success(model))
                } else {
                    completion(.failure(NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Document not found"])))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func create(_ model: Model, withID id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try collection.document(id).setData(from: model) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func update(_ model: Model, withID id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try collection.document(id).setData(from: model, merge: true) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func delete(byID id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        collection.document(id).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchFilteredUsers(completion: @escaping (Result<[Model], Error>) -> Void) {
        
        // Build the query
        let query = collection
            .whereField("ge", isEqualTo: 0) // Filter for female users
            .order(by: "la", descending: true) // Recently active
            .order(by: "rating", descending: true) // Highest rating
            .order(by: "sp", descending: false) // Lowest service pricing
        
        // Execute the query
        query.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No users found.")
                completion(.success([]))
                return
            }
            
            do {
                // Map documents to UserJSON objects
                let models: [Model] = try documents.map { try $0.data(as: Model.self) }
                completion(.success(models))
            } catch {
                print("Error decoding user data: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
