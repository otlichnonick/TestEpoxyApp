//
//  ColorView.swift
//  TestEpoxyApp
//
//  Created by Anton Agafonov on 11.01.2022.
//

import UIKit
import Epoxy

final class ColorView: UIView, EpoxyableView {
//    private let size: CGSize?
    
    init(style: Style) {
//        size = style.size
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = style.color
        layer.cornerRadius = style.cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Style: Hashable {
//        var size: CGSize? = nil
        var color = UIColor.red
        var cornerRadius: CGFloat = 0
        
        func hash(into hasher: inout Hasher) {
//            hasher.combine(size?.width)
//            hasher.combine(size?.height)
            hasher.combine(color)
            hasher.combine(cornerRadius)
        }
    }
    
//    override var intrinsicContentSize: CGSize {
//        size ?? super.intrinsicContentSize
//    }
}
