//
//  ViewController.swift
//  TestEpoxyApp
//
//  Created by Anton Agafonov on 10.01.2022.
//

import UIKit
import Epoxy
import GXUtilz

class ViewController: UIViewController {
    
    let collectionView = CollectionView(layout: UICollectionViewLayout())
    
    override func viewDidLoad() {
      super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.setSections(sections, animated: true)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
      collectionView.alwaysBounceVertical = true
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private enum DataID {
      enum Section {
        case first
          case second
          case third
      }

      enum First {
        case one
          case two
      }

      enum Second {
        case one
      }

      enum Third {
        case one
          case two
          case three
      }
    }
    
    @SectionModelBuilder private var sections: [SectionModel] {
      redSection
    }
    
    private var redSection: SectionModel {
        SectionModel(dataID: DataID.Section.first) {
            ColorView.itemModel(dataID: DataID.First.one, style: .init(color: .red, cornerRadius: 10))
            ColorView.itemModel(dataID: DataID.First.two, style: .init(color: .yellow, cornerRadius: 20))
        }
    }
}


