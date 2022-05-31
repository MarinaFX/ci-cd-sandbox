//
//  ParadiseOnCombineTests.swift
//  ParadiseOnCombineTests
//
//  Created by Marina De Pazzi on 31/05/22.
//

import XCTest
import Combine
@testable import ParadiseOnCombine

class ParadiseOnCombineTests: XCTestCase {
    
    var sut: RepoViewModel!
    var repositories: [Repository] = []
    var disposables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.sut = .init()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRepositoriesRequest() {
        let repoRequestExpectation = expectation(description: "Repo Request Expectation")
        
        sut.$repositories
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .finished:
                        print("completion finished successfully")
                }
            } receiveValue: { [unowned self] repositories in
                self.repositories = repositories
                repoRequestExpectation.fulfill()
            }
            .store(in: &disposables)
        
        sut.fetchRepos()
        
        wait(for: [repoRequestExpectation], timeout: 5)
        XCTAssertNotNil(repositories)
    }
}
