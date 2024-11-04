//
//  FirebaseManager.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 1.11.2024.
//

import Foundation
import NeonSDK

class FirebaseManager {
    static let shared = FirebaseManager()
    
    private init() { }
    
    
    // MARK: - Add Functions
    
    func addFeeding(feedingModel : FeedingFirebaseModel,uuid : String) {
        
        if let currentUser = AuthManager.currentUserID {
            FirestoreManager.setDocument(path: [
                .collection(name: "Users"),
                .document(name: currentUser),
                .collection(name: "Feeding"),
                .document(name: uuid)
            ], object: feedingModel)
        }
    }
    
    func addSleep(sleepModel : SleepFirebaseModel,uuid : String) {
        
        if let currentUser = AuthManager.currentUserID {
            FirestoreManager.setDocument(path: [
                .collection(name: "Users"),
                .document(name: currentUser),
                .collection(name: "Sleep"),
                .document(name: uuid)
            ], object: sleepModel)
        }
        
    }
    
    func addSymptomps(symptompsModel : SymptompsFirebaseModel,uuid : String) {
        if let currentUser = AuthManager.currentUserID {
            FirestoreManager.setDocument(path: [
                .collection(name: "Users"),
                .document(name: currentUser),
                .collection(name: "Symptomps"),
                .document(name: uuid)
            ], object: symptompsModel)
        }
    }
    
    
    // MARK: - Get
    
    var firebaseDataModel = FirebaseDataModel(sleep: [], feeding: [], symptomps: [])
    
    
    func fetchAllData(completion: @escaping (FirebaseDataModel) -> Void) {
        
        fetchSleepData { sleepData in
            self.firebaseDataModel.sleep = sleepData
            
            
            self.fetchFeedingData { feedingData in
                self.firebaseDataModel.feeding = feedingData
                
                
                self.fetchSymptompsData { symptompsData in
                    self.firebaseDataModel.symptomps = symptompsData
                    
                    
                    completion(self.firebaseDataModel)
                }
            }
        }
        
        
    }
    
    private func fetchSleepData(completion: @escaping ([SleepFirebaseModel]) -> Void) {
        var data: [SleepFirebaseModel] = []
        if let currentUser = AuthManager.currentUserID {
            FirestoreManager.getDocuments(path: [
                .collection(name: "Users"),
                .document(name: currentUser),
                .collection(name: "Sleep")
            ], objectType: SleepFirebaseModel.self) { object in
                if let sleepData = object as? SleepFirebaseModel {
                    data.append(sleepData)
                }
                completion(data)
            } isCollectionEmpty: {
                completion(data)
            }
        } else {
            completion(data)
        }
    }
    
    private func fetchFeedingData(completion: @escaping ([FeedingFirebaseModel]) -> Void) {
        var data: [FeedingFirebaseModel] = []
        if let currentUser = AuthManager.currentUserID {
            FirestoreManager.getDocuments(path: [
                .collection(name: "Users"),
                .document(name: currentUser),
                .collection(name: "Feeding")
            ], objectType: FeedingFirebaseModel.self) { object in
                if let feedingData = object as? FeedingFirebaseModel {
                    data.append(feedingData)
                }
                completion(data)
            } isCollectionEmpty: {
                completion(data)
            }
        } else {
            completion(data)
        }
    }
    
    private func fetchSymptompsData(completion: @escaping ([SymptompsFirebaseModel]) -> Void) {
        var data: [SymptompsFirebaseModel] = []
        if let currentUser = AuthManager.currentUserID {
            FirestoreManager.getDocuments(path: [
                .collection(name: "Users"),
                .document(name: currentUser),
                .collection(name: "Symptomps")
            ], objectType: SymptompsFirebaseModel.self) { object in
                if let symptomData = object as? SymptompsFirebaseModel {
                    data.append(symptomData)
                }
                completion(data)
            } isCollectionEmpty: {
                completion(data)
            }
        } else {
            completion(data)
        }
    }
    
    
    
    //MARK: - Delete
    
    func deleteFeedFromFireBase (id : String) {
        if let currentUser = AuthManager.currentUserID {
            FirestoreManager.deleteDocument(path: [
                .collection(name: "Users"),
                .document(name: currentUser),
                .collection(name: "Feeding"),
                .document(name: id)
            ])
        }
    }
    
    func deleteSleepFromFireBase (id : String) {
        if let currentUser = AuthManager.currentUserID {
            FirestoreManager.deleteDocument(path: [
                .collection(name: "Users"),
                .document(name: currentUser),
                .collection(name: "Sleep"),
                .document(name: id)
            ])
        }
    }
    
    func deleteSymptompsFromFireBase (id : String) {
        if let currentUser = AuthManager.currentUserID {
            FirestoreManager.deleteDocument(path: [
                .collection(name: "Users"),
                .document(name: currentUser),
                .collection(name: "Symptomps"),
                .document(name: id)
            ])
        }
    }
}
