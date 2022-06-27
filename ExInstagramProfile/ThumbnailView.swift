//
//  ThumbnailView.swift
//  ExInstagramProfile
//
//  Created by Jake.K on 2022/06/24.
//

import UIKit
import SnapKit
import Then

class ThumbnailView: RoundView {
  // MARK: Constants
  private enum Const {
    // view
    static let imageOuterSpacing = Self.gradationWidth + 4.0 // borderWidth만큼 안쪽으로 바깥 라인이 채워지므로 borderWidth값을 더함
    static let greenDotOuterSpacing = 4.0
    static let greenDotViewInset = UIEdgeInsets(top: 0, left: 0, bottom: 11, right: 11)
    static let greenDotViewSize = CGSize(width: 16, height: 16)
    
    // shapeLayer
    static let gradationWidth = 2.0
  }
  
  // MARK: UI
  private let containerView = RoundView().then {
    $0.backgroundColor = .clear
    $0.isUserInteractionEnabled = false
    $0.clipsToBounds = true
  }
  private let thumbnailImageView = RoundImageView().then {
    $0.clipsToBounds = true
    $0.contentMode = .scaleAspectFill
  }
  private let greenDotContainerView = RoundView().then {
    $0.isUserInteractionEnabled = false
    $0.backgroundColor = .white
    $0.clipsToBounds = true
    
    let greenDotView = RoundView().then {
      $0.backgroundColor = .green
    }
    $0.addSubview(greenDotView)
    greenDotView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(Const.greenDotOuterSpacing)
    }
  }
  private var gradientLayer = CAGradientLayer().then {
    $0.colors = [UIColor.red, .systemPink, .yellow].map(\.cgColor)
  }
  private var shapeLayer = CAShapeLayer().then {
    $0.lineWidth = Const.gradationWidth
    $0.strokeColor = UIColor.black.cgColor
    $0.fillColor = UIColor.clear.cgColor
  }
  
  // MARK: Properties
  var image: UIImage? {
    didSet { self.thumbnailImageView.image = self.image }
  }
  var shouldShowGreenDot = true {
    didSet { self.greenDotContainerView.isHidden = !self.shouldShowGreenDot }
  }
  
  // MARK: Initializer
  required init?(coder: NSCoder) {
    fatalError()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.containerView.layer.addSublayer(self.gradientLayer)
    self.gradientLayer.mask = self.shapeLayer
    
    self.addSubview(self.containerView)
    self.addSubview(self.greenDotContainerView)
    self.containerView.addSubview(self.thumbnailImageView)
    
    self.containerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    self.thumbnailImageView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(Const.imageOuterSpacing)
    }
    self.greenDotContainerView.snp.makeConstraints {
      $0.right.bottom.equalToSuperview().inset(Const.greenDotViewInset)
      $0.size.equalTo(Const.greenDotViewSize)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    guard self.containerView.bounds != .zero else { return }
    
    self.gradientLayer.frame = self.containerView.bounds
    self.shapeLayer.path = UIBezierPath(
      roundedRect: self.containerView.bounds.insetBy(dx: Const.gradationWidth, dy: Const.gradationWidth),
      cornerRadius: self.bounds.height / 2.0
    ).cgPath
  }
}
