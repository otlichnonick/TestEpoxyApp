//
//  ViewController.swift
//  TestEpoxyApp
//
//  Created by Anton Agafonov on 10.01.2022.
//

import UIKit
import Epoxy
import GXUtilz

class MainViewController: CollectionViewController {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(layout: layout)
        setSections(sections, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.alwaysBounceVertical = true
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
        firstSection
        secondSection
    }
    
    private var firstSection: SectionModel {
        SectionModel(dataID: DataID.Section.first) {
            ColorView.itemModel(dataID: DataID.First.one, style: .init())
                            .flowLayoutItemSize(.init(width: .displayWidth(50), height: .displayWidth(50)))
            ColorView.itemModel(dataID: DataID.First.two, style: .init(color: .yellow, cornerRadius: 20))
                            .flowLayoutItemSize(.init(width: .displayWidth(50), height: .displayWidth(25)))
        }
        .flowLayoutMinimumInteritemSpacing(0)
        .flowLayoutSectionInset(UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
    }
    
    private var secondSection: SectionModel {
        SectionModel(dataID: DataID.Section.second, items: [
            ColorView.itemModel(dataID: 1, style: .init(color: .yellow)),
            ColorView.itemModel(dataID: 2, style: .init(color: .black)),
            ColorView.itemModel(dataID: 3, style: .init(color: .green))
        ])
    }
}

struct Card {
    var imageUrl: String
    var title: String
    var id: UUID = UUID()
}

