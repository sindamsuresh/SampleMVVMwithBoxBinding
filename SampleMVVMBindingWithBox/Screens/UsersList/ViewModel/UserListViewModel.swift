//
//  UserListViewModel.swift
//  SampleMVVMBindingWithBox
//
//  Created by Suresh Sindam on 1/14/24.
//

import Foundation

struct UserListViewModel {
    
    var userData: Observable<[UserModel]> = Observable(value: [])
    
    private let networkManager: NetworkManaging
        
        init(networkManager: NetworkManaging = NetworkManager()) {
            self.networkManager = networkManager
        }
    
    func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        
        networkManager.getUsers(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let usersData = try JSONDecoder().decode([UserModel].self, from: data)
                    self.userData.value = usersData
                } catch {
                    print("Error decoding data: \(error)")
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
        
    }
}
