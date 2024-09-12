//
//  ViewModel.swift
//  Combine+RXSwiftTests
//
//

import Combine
import Foundation

final class ViewModel {

    // MARK: - Private Properties

    private let networkManager: NetworkManager

    private var cancellables = Set<AnyCancellable>()
    private var currentRequest: AnyCancellable?

    // MARK: - Init

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    // MARK: - Internal Methods

    func fetchData(searchText: String) -> AnyPublisher<[City], Never> {
        // Отменяем запрос, если пользователь вводит текст снова после старта запроса
        currentRequest?.cancel()

        let addressesPublisher = networkManager.fetchAddresses(from: searchText)
            .eraseToAnyPublisher()

        let sightsPublisher = networkManager.fetchSights(from: searchText)
            .eraseToAnyPublisher()
        
        // Publishers.Zip - позволяет запускать запросы параллельно
        let combinedPublisher = Publishers.Zip(addressesPublisher, sightsPublisher)
            .flatMap { [weak self] addresses, sights -> AnyPublisher<[City], Never> in
                guard let self = self else {
                    return Just([]).eraseToAnyPublisher()
                }

                return self.networkManager.fetchImages(from: addresses, sights: sights)
                    .map { images in
                        // Двойной zip условность для быстрой сборки масивов в один
                        let cities: [City] = zip(zip(addresses, sights), images)
                            .compactMap { (addressSightTuple, imageURL) -> City? in
                                let (address, sight) = addressSightTuple
                                return City(address: address, sight: sight, imageURL: imageURL)
                            }
                        return cities
                    }
                    .eraseToAnyPublisher()
            }

        let request = combinedPublisher
            .handleEvents { [weak self] subscription in
                self?.currentRequest = AnyCancellable(subscription)
            }
            .eraseToAnyPublisher()

        return request
    }

}
