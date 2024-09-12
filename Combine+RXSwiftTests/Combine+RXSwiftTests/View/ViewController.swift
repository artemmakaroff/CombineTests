//
//  ViewController.swift
//  Combine+RXSwiftTests
//
//

import Combine
import UIKit

final class ViewController: UIViewController {

    // MARK: - Subviews

    private let textField = UITextField()
    private let tableView = UITableView()

    // MARK: - Private Properties

    private let viewModel: ViewModel

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }


}

// MARK: - Private Methods

private extension ViewController {

    func setupTextFieldPublisher() {
        let textPublisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
            .compactMap { ($0.object as? UITextField)?.text }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()

        textPublisher
            .sink { [weak self] query in
                guard let self = self else { return }
                self.viewModel.fetchData(searchText: query)
                    .sink(receiveValue: { cities in
                        print("Cities - \(cities)")
                    })
                    .store(in: &self.cancellables)
            }
            .store(in: &cancellables)
    }

}

// MARK: - Appearance

private extension ViewController {

    func setup() {
        view.backgroundColor = .gray

        setupTextField()
        setupTableView()
    }

    func setupTextField() {
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 6
        textField.layer.masksToBounds = false
        view.addSubview(textField)

        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        setupTextFieldPublisher()
    }

    func setupTableView() {
        // TODO: - Setup tableView
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

