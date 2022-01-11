//
//  Label.swift
//  TestEpoxyApp
//
//  Created by Anton Agafonov on 11.01.2022.
//

import EpoxyCore
import UIKit

//final class Label: UILabel, EpoxyableView {
//
//    init(style: Style) {
//        super.init(frame: .zero)
//        translatesAutoresizingMaskIntoConstraints = false
//        font = style.font
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    struct Style: Hashable {
//        let font: UIFont
//
//        static func style(with font: UIFont) -> Label.Style {
//            .init(font: font)
//        }
//    }
//}


final class Label: UILabel, EpoxyableView {

  // MARK: Lifecycle

  init(style: Style) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    font = style.font
    numberOfLines = style.numberOfLines
    if style.showLabelBackground {
      backgroundColor = .secondarySystemBackground
    }
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  // MARK: StyledView

  struct Style: Hashable {
    let font: UIFont
    let showLabelBackground: Bool
    var numberOfLines = 0
  }

  // MARK: ContentConfigurableView

  typealias Content = String

  func setContent(_ content: String, animated _: Bool) {
    text = content
  }

}

extension Label.Style {
  static func style(
    with textStyle: UIFont.TextStyle,
    showBackground: Bool = false)
    -> Label.Style
  {
    .init(
      font: UIFont.preferredFont(forTextStyle: textStyle),
      showLabelBackground: showBackground)
  }
}
