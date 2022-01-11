//
//  TextView.swift
//  TestEpoxyApp
//
//  Created by Anton Agafonov on 11.01.2022.
//

import UIKit
import Epoxy

//final class TextView: UIView, EpoxyableView {
//    private let group = VGroup(spacing: 10)
//    private let style: Style
//
//    init(style: Style) {
//        self.style = style
//        super.init(frame: .zero)
//        translatesAutoresizingMaskIntoConstraints = false
//        group.install(in: self)
//        group.constrainToMarginsWithHighPriorityBottom()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    struct Content: Equatable {
//        var quote: String
//        var author: String
//    }
//
//    struct Style: Hashable {
//        var quoteFont = UIFont.systemFont(ofSize: 14)
//        var authorFont = UIFont.systemFont(ofSize: 10)
//    }
//
//    func setContent(_ content: Content, animated: Bool) {
//        group.setItems {
//            Label.groupItem(dataID: "quote",
//                            content: content.author,
//                            style: .style(with: style.quoteFont))
//              .adjustsFontForContentSizeCategory(true)
//              .textColor(UIColor.label)
//
//            Label.groupItem(dataID: "author",
//                            content: content.author,
//                            style: Label.Style(font: style.authorFont))
//              .adjustsFontForContentSizeCategory(true)
//              .numberOfLines(0)
//              .textColor(UIColor.secondaryLabel)
//        }
//    }
//}


final class TextView: UIView, EpoxyableView {

  // MARK: Lifecycle

  init() {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
      layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    group.install(in: self)
//      group.constrainToMargins()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal
  struct Content: Equatable {
    var quote: String
    var author: String
  }

  func setContent(_ content: Content, animated _: Bool) {
    group.setItems {
        Label.groupItem(
          dataID: DataID.quote,
          content: content.quote,
          style: .style(with: .headline))
          .adjustsFontForContentSizeCategory(true)
          .textColor(UIColor.label)
          .numberOfLines(0)

        Label.groupItem(
          dataID: DataID.author,
          content: content.author,
          style: .style(with: .body))
          .adjustsFontForContentSizeCategory(true)
          .textColor(UIColor.secondaryLabel)
    }
  }

  private enum DataID {
    case quote
    case author
  }

  private let group = VGroup(spacing: 0)
}

// MARK: SelectableView

extension TextView: SelectableView {
  func didSelect() {
    // Handle this row being selected, e.g. to trigger haptics:
    UISelectionFeedbackGenerator().selectionChanged()
  }
}

// MARK: HighlightableView

extension TextView: HighlightableView {
  func didHighlight(_ isHighlighted: Bool) {
    UIView.animate(withDuration: 0.15, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction]) {
      self.transform = isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
    }
  }
}

// MARK: DisplayRespondingView

extension TextView: DisplayRespondingView {
  func didDisplay(_: Bool) {
    // Handle this row being displayed.
  }
}
