//
//  MovieViewController.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import UIKit

class MovieViewController: UIViewController {
    
// MARK: - Properties
    weak var coordinator: AppCoordinator?
    
    private let viewModel: MovieViewModelType
    
    private lazy var tableView: UITableView = {
      let tableView = UITableView(frame: .zero, style: .plain)
      tableView.dataSource = self
      tableView.delegate = self
      tableView.showsVerticalScrollIndicator = false
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.contentInsetAdjustmentBehavior = .never
      tableView.separatorStyle = .singleLine
      tableView.rowHeight = UITableView.automaticDimension
      tableView.estimatedRowHeight = 100
      tableView.register(MovieTableCell.self, forCellReuseIdentifier: MovieTableCell.identifier)
      tableView.layer.cornerRadius = 10
      return tableView
    }()

    init(with viewModel: MovieViewModelType = MovieViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
}

// MARK: - Setup UI & Eevnts
extension MovieViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindToViewModel()
    }
    
    func bindToViewModel() {
        
        viewModel.moviesList.bind(listener: { [weak self] _ in
            self?.tableView.reloadData()
        })

        viewModel.error.bind(listener: { [weak self] error in
            guard let self = self, let msg = error else { return }
            self.show(error: msg)
        })
        
    }

    func setupUI() {
        title = "Movies"
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        tableView.setConstrainsEqualToParent(edge: [.leading, .trailing], with: 20)
        tableView.setConstrainsEqualToParent(edge: [.top], with: 90)
        tableView.setConstrainsEqualToParent(edge: [.bottom], with: 30)
    }
}


// MARK: - Table view data source
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesList.value.count
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: MovieTableCell.self, for: indexPath)
        cell.setData(for: viewModel, row: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.movieDetail(viewModel.moviesList.value[indexPath.row].id ?? 0)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == viewModel.moviesList.value.count {
            viewModel.loadMoreData()
        }
    }
}
