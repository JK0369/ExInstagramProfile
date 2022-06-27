//
//  RoundImageView.swift
//  ExInstagramProfile
//
//  Created by Jake.K on 2022/06/27.
//

import UIKit

class RoundImageView: UIImageView {
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.clipsToBounds = true
    self.layer.cornerRadius = self.bounds.height / 2.0
  }
}
