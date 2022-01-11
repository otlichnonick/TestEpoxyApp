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
    
        enum Section {
            case colors
            case cards
            case quotes
        }
    
    @SectionModelBuilder private var sections: [SectionModel] {
        firstSection
        secondSection
    }
    
    private var firstSection: SectionModel {
        SectionModel(dataID: Section.colors) {
            ColorView.itemModel(dataID: "DataID.First.one", style: .init())
                            .flowLayoutItemSize(.init(width: .displayWidth(50), height: .displayWidth(50)))
            ColorView.itemModel(dataID: "DataID.First.two", style: .init(color: .yellow, cornerRadius: 20))
                            .flowLayoutItemSize(.init(width: .displayWidth(50), height: .displayWidth(25)))
        }
        .flowLayoutSectionInset(UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        .flowLayoutMinimumInteritemSpacing(0)
    }
    
    private var secondSection: SectionModel {
        SectionModel(dataID: Section.quotes) {
            quotes.map { item in
                TextView.itemModel(dataID: item.quote,
                                   content: .init(quote: item.quote, author: item.author))
            }
        }
    }
    
    private var quotes: [Statement] = [
        Statement(quote: "Падает тот, кто бежит. Тот, кто ползет, не падает.", author: "Плиний Старший"),
        Statement(quote: "Человек должен мечтать, чтобы видеть смысл жизни.", author: "Вольтер"),
        Statement(quote: "Влюбиться? Влюбляться не значит любить. Влюбиться можно и ненавидя.", author: "Достоевский")
    ]
}

struct Card {
    var imageUrl: String
    var title: String
    var id: UUID = UUID()
}

struct Statement {
    var quote: String
    var author: String
}
