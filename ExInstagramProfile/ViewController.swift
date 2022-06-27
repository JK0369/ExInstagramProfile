//
//  ViewController.swift
//  ExInstagramProfile
//
//  Created by Jake.K on 2022/06/24.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {
  private let thumbnailView = ThumbnailView().then {
    $0.image = UIImage(named: "dog")
    $0.shouldShowGreenDot = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(self.thumbnailView)
    
    self.thumbnailView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.size.equalTo(CGSize(width: 100, height: 100))
    }
  }
}
