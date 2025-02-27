//
//  FetchDataUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/27.
//

import Foundation

class FetchDataUseCase : FetchDataUseCaseProtocol {
    
    private let service: NothingService
    
    init (service: NothingService) {
        self.service = service
    }
    
    func fetchData() {
        service.fetchData()
    }
    
    
}
