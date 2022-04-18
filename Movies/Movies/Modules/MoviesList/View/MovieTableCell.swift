//
//  MovieTableCell.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import UIKit
import Combine

class MovieTableCell: UITableViewCell {
    
// MARK: - Properties
    private var cancellable: AnyCancellable?
    private var animator =  UIActivityIndicatorView(style: .medium)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 3
        label.textColor = .gray
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .gray
        return label
    }()

    private lazy var avater: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var textStack: UIStackView = {
      let stackView = UIStackView()
      stackView.alignment = .leading
      stackView.distribution = .fill
      stackView.axis = .vertical
      stackView.isLayoutMarginsRelativeArrangement = true
      stackView.spacing = 0
      return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
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
extension MovieTableCell: LoadImageDataSource {
    
    func setData(for viewModel: MovieViewModelType, row: Int) {
        let movieObj = viewModel.moviesList.value[row]
        titleLabel.text = movieObj.title
        dateLabel.text = movieObj.releaseDate
        descriptionLabel.text = movieObj.overview
        setupImage(imageName: movieObj.posterPath)
    }
    
    private func setupImage(imageName: String?) {
        guard let imageName = imageName, !imageName.isEmpty else {
            avater.image = UIImage(named: Constants.emptyPosterImage)
            return }
        avater.addSubview(animator)
        animator.startAnimating()
        animator.center = avater.center
        cancellable = loadImage(for: imageName.fullImagePath(size: .w500)).sink { [weak self] image in
            self?.showImage(image: image)
        }
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

// MARK: - setup UI
extension MovieTableCell {
    
    private func setupUI() {
        backgroundColor = .systemGray6
        selectionStyle = .none
        [avater, textStack].forEach {contentView.addSubview($0)}
        avater.setConstrainsEqualToParent(edge: [.leading, .bottom, .top], with: 10)
        textStack.setConstrainsEqualToParent(edge: [.bottom, .top, .trailing], with: 10)
        NSLayoutConstraint.activate([
            avater.widthAnchor.constraint(equalToConstant: 80),
            avater.heightAnchor.constraint(equalToConstant: 105)])
        NSLayoutConstraint.activate([
                    textStack.leftAnchor.constraint(equalTo:
                                                        avater.rightAnchor, constant: 10)])
        [titleLabel, dateLabel, descriptionLabel].forEach {textStack.addArrangedSubview($0)}
    }
    
}

