//
//  LoadableObject.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 08/04/2024.
//

import Foundation
import Combine

enum LoadingState {
    case idle
    case loading
    case failed(APIErrorHandler)
    case loaded
}

protocol LoadableObject: AnyObject {
    var loadingState: LoadingState { get set }
    var cancellables: Set<AnyCancellable> { get set }    
}
