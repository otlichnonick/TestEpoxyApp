//
//  ViewController.swift
//  TestEpoxyApp
//
//  Created by Anton Agafonov on 10.01.2022.
//

import UIKit
import Epoxy

class ViewController: UIViewController {
    private enum SectionID {
        case images
    }
    
    private enum RowID {
        case first
    }
    
    private var collectionView = CollectionView(layout: UICollectionViewLayout())
    
    @ItemModelBuilder
    private var items: [ItemModeling] {
        ImageRow.itemModel(dataID: RowID.first, content: .init(title: "Заповедные места", subtitle: "Озеро Джека Лондона", imageURL: URL(string: "https://www.culture.ru/storage/images/298a5b1bf4ce47a8ce3b16bff55772f8/809edd7775f120b055382b101740a4a8.jpeg")!))
    }
    
    private var sections: [SectionModel] {
        [SectionModel(dataID: SectionID.images, items: items)]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        updateSections(animated: false)
    }

    private func updateSections(animated: Bool) {
        collectionView.setSections(sections, animated: animated)
    }
}

// MARK: ImageRow

  class ImageRow: UIView, EpoxyableView {
      
      init() {
          super.init(frame: .zero)
          translatesAutoresizingMaskIntoConstraints = false
          setup()
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      struct Content: Equatable {
        let title: String
        let subtitle: String
        let imageURL: URL
      }
      
      func setContent(_ content: Content, animated _: Bool) {
        titleLabel.text = content.title
        subtitleLabel.text = content.subtitle
        imageView.load(content.imageURL)
      }
      
      private var group = VGroup()
      
      private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.numberOfLines = 2
          debugPrint("titleLabel was called")
        return label
      }()
      
      private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
      }()
      
      private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return imageView
      }()
      
      private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
      }()
      
      private func setup() {
        addSubview(labelStackView)
        addSubview(imageView)
        let imageBottomConstraint = imageView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        imageBottomConstraint.priority = .defaultLow
        NSLayoutConstraint.activate([
          imageBottomConstraint,
          imageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
          imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
          labelStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
          labelStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
          labelStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
          labelStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
        ])
        layoutMargins = UIEdgeInsets(top: 20, left: 24, bottom: 20, right: 24)
      }
  }

extension UIImageView {
    func load(_ url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
