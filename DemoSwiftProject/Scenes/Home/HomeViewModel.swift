//
//  HomeViewModel.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 08/04/2024.
//

import Foundation
import Combine

protocol HomeViewModelRepresentable: AnyObject {
    var contributors: [Contributor] { get }
    
    var didLoadContributors: (() -> Void)? { get set }
}

final class HomeViewModel: HomeViewModelRepresentable, LoadableObject {
    var didLoadContributors: (() -> Void)?
    
    /// HomeViewModelRepresentable conformance
    
    /// LoadableObject conformance
    var loadingState: LoadingState = .idle {
        didSet {
            switch loadingState {
            case .idle:
                break
            case .loading:
                break
            case .failed(let error):
                print(error)
            case .loaded:
                didLoadContributors?()
            }
        }
    }
    var cancellables = Set<AnyCancellable>()
    var contributors: [Contributor] = []
    
    /// Depedencies
    private let homeService: HomeServiceInterface
    
    init(homeService: HomeServiceInterface) {
        self.homeService = homeService
        fetchContributors()
    }
    
    func extractSingleContributor(at indexPath: IndexPath) -> Contributor {
        let contributor = contributors[indexPath.row]
        return contributor
    }
}

extension HomeViewModel {
    func fetchContributors() {
        homeService.getContributor()
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.loadingState = .failed(error)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.contributors = response.map({ response in
                    return Contributor(id: response.id, avatar: response.avatar, url: response.url)
                })
                self.fetchAvatarImage()
            }
            .store(in: &cancellables)
    }
    
    func fetchAvatarImage() {
        let group = DispatchGroup()
        for (index, contributor) in contributors.enumerated() {
            group.enter()
            homeService.getAvatarImage(from: contributor.avatar)
                .sink { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .finished:
                        self.loadingState = .idle
                    case .failure(let error):
                        self.loadingState = .failed(error)
                    }
                } receiveValue: { data in
                    self.contributors[index].avatarData = data
                    group.leave()
                }
                .store(in: &cancellables)
        }
        
        group.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            print("First")
            print(contributors)
            self.loadingState = .loaded
        }
    }
}
