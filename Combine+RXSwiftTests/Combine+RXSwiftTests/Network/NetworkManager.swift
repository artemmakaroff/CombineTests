//
//  NetworkManager.swift
//  Combine+RXSwiftTests
//
//

import Combine
import Foundation

final class NetworkManager {

    // MARK: - Internal Methods

    func fetchAddresses(from searchText: String) -> AnyPublisher<[Address], Never> {
        // TODO: - Handle Error and handle searchText
        sleep(1)

        return Just(AddressesMockFabric.getAddresses())
            .eraseToAnyPublisher()
    }

    func fetchSights(from searchText: String) -> AnyPublisher<[Sight], Never> {
        // TODO: - Handle Error and handle searchText
        sleep(1)

        return Just(SightsMockFabric.getSights())
            .eraseToAnyPublisher()
    }

    // Можно было бы объединить модели адреса и достопримечательности в одну какую-то общую, но возьму смелость для примера использовать так
    func fetchImages(from addresses: [Address], sights: [Sight]) -> AnyPublisher<[String], Never> {
        let models = zip(addresses, sights)
        var imageUrls: [String] = []
        models.forEach { _ in
            imageUrls.append("https://farm4.staticflickr.com/3075/3168662394_7d7103de7d_z_d.jpg")
        }
        return Just(imageUrls)
            .eraseToAnyPublisher()
    }

}
