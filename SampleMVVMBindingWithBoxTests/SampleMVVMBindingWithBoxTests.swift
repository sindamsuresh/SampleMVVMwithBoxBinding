//
//  SampleMVVMBindingWithBoxTests.swift
//  SampleMVVMBindingWithBoxTests
//
//  Created by Suresh Sindam on 1/14/24.
//

import XCTest
@testable import SampleMVVMBindingWithBox

final class SampleMVVMBindingWithBoxTests: XCTestCase {

    class UserListViewModelTests: XCTestCase {
        
        class MockNetworkManager: NetworkManaging {
            var getUsersCalled = false
            var result: Result<Data, NetworkError>?
            
            func getUsers(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
                getUsersCalled = true
                if let result = result {
                    completion(result)
                }
            }
        }
        
        func testFetchDataSuccess() {
            // Given
            let mockNetworkManager = MockNetworkManager()
            mockNetworkManager.result = .success(Data())
            
            var viewModel = UserListViewModel(networkManager: mockNetworkManager)
            
            // When
            viewModel.fetchData()
            
            // Then
            XCTAssertTrue(mockNetworkManager.getUsersCalled)
            // Add assertions for the expected behavior when the network call is successful
        }
        
        func testFetchDataFailure() {
            // Given
            let mockNetworkManager = MockNetworkManager()
            mockNetworkManager.result = .failure(.invalidData)
            
            var viewModel = UserListViewModel(networkManager: mockNetworkManager)
            
            // When
            viewModel.fetchData()
            
            // Then
            XCTAssertTrue(mockNetworkManager.getUsersCalled)
            // Add assertions for the expected behavior when the network call fails
        }

}
