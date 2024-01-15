//
//  ViewController.swift
//  SampleMVVMBindingWithBox
//
//  Created by Suresh Sindam on 1/14/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let userListViewModel = UserListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch data when the view is loaded
        userListViewModel.fetchData()
        
        
        // Bind to the userData changes for UI updates
        userListViewModel.userData.bind { [weak self] value in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListViewModel.userData.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let users = userListViewModel.userData.value
        cell.textLabel?.text = users?[indexPath.row].name
        return cell
    }
    
    
}
