//
//  MovieDetailCell.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import UIKit
import Combine

class MovieDetailCell: UITableViewCell {
    
// MARK: - Properties
    private var cancellable: AnyCancellable?
    private var animator =  UIActivityIndicatorView(style: .large)

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var avater: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .gray.withAlphaComponent(0.2)
        return image
    }()
    
    private lazy var ratingStack: UIStackView = {
      let stackView = UIStackView()
      stackView.alignment = .leading
      stackView.distribution = .fill
      stackView.axis = .horizontal
      stackView.isLayoutMarginsRelativeArrangement = true
      stackView.spacing = 5
      return stackView
    }()

    private lazy var ratingAvater: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = .clear
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .systemYellow
        return image
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .gray
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override public func prepareForReuse() {
         super.prepareForReuse()
        disposeData()
     }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
}

//  MARK: - Set Data & Image Setup
extension MovieDetailCell: LoadImageDataSource {
    
    func setData(for viewModel: MovieDetailViewModelType, row: Int) {
        if let movieObj = viewModel.movieDetail.value {
            titleLabel.text = movieObj.title
            descriptionLabel.text = movieObj.overview
            dateLabel.text = movieObj.releaseDate
            ratingLabel.text = viewModel.calculateRating(popularity: movieObj.popularity ?? 1)
            setupImage(imageName: movieObj.posterPath)
        }
    }
    
    private func setupImage(imageName: String?) {
        guard let imageName = imageName, !imageName.isEmpty else {
            avater.image = UIImage(named: Constants.emptyPosterImage)
            return
        }
        avater.addSubview(animator)
        animator.startAnimating()
        animator.center = avater.center
        cancellable = loadImage(for: imageName.fullImagePath(size: .original)).sink { [weak self] image in self?.showImage(image: image) }
    }
    
    private func showImage(image: UIImage?) {
        avater.image = image
        animator.removeFromSuperview()
    }
    
    private func disposeData() {
        avater.image = nil
        animator.removeFromSuperview()
        cancellable?.cancel()
    }
    
}

// MARK: - Setup UI
extension MovieDetailCell {
    
    private func setupUI() {
        [avater, titleLabel, dateLabel, ratingStack, descriptionLabel].forEach {contentView.addSubview($0)}
        avater.setConstrainsEqualToParent(edge: [.leading, .trailing, .top], with: 0)
        descriptionLabel.setConstrainsEqualToParent(edge: [.leading, .trailing], with: 12)
        titleLabel.setConstrainsEqualToParent(edge: [.leading, .trailing], with: 12)
        dateLabel.setConstrainsEqualToParent(edge: [.leading, .trailing], with: 12)
        ratingStack.setConstrainsEqualToParent(edge: [.leading, .trailing], with: 12)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: avater.bottomAnchor, constant: 12),
            ])
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            ])
        NSLayoutConstraint.activate([
            avater.heightAnchor.constraint(equalToConstant: 600)
        ])
        NSLayoutConstraint.activate([
            ratingStack.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: ratingStack.bottomAnchor, constant: 12),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)])
        
        [ratingAvater, ratingLabel].forEach {ratingStack.addArrangedSubview($0)}
        NSLayoutConstraint.activate([
            ratingAvater.leftAnchor.constraint(equalTo: ratingStack.leftAnchor, constant: 0),
            ])
        NSLayoutConstraint.activate([
            ratingAvater.heightAnchor.constraint(equalToConstant: 20),
            ratingAvater.widthAnchor.constraint(equalToConstant: 20)
        ])
        selectionStyle = .none
    }
    
}

