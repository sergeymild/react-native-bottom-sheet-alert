import Foundation
import UIKit

private func with(color: UIColor, alpha: CGFloat = 1.0) -> UIImage? {
  let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
  UIGraphicsBeginImageContext(rect.size)
  if let context = UIGraphicsGetCurrentContext() {
    context.setFillColor(color.withAlphaComponent(alpha).cgColor)
    context.fill(rect)
  }
  let image = UIGraphicsGetImageFromCurrentImageContext()
  UIGraphicsEndImageContext()
  return image!
}

public class ListTileView: UIView {
  var tapCallback: (() -> Void)?
  
  public let position: Int
  
  var applyLeftIconSpace = false
  public var leftIcon: UIImage? = nil {
    didSet {
      leftIconView.image = leftIcon
      addSubview(leftIconView)
    }
  }
  
  public var isWarning = false {
    didSet {
      if isWarning {
        titleLabel.textColor = .red
        leftIconView.tintColor = .red
      }
    }
  }
  
  fileprivate let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    label.textColor = .black
    label.isUserInteractionEnabled = false
    return label
  }()
  
  public lazy var leftIconView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.isUserInteractionEnabled = false
    return imageView
  }()
  
  let button = UIButton()
  
  public init(title: String, position: Int = 0) {
    self.position = position
    super.init(frame: .zero)
    titleLabel.text = title
    addSubview(titleLabel)
    addSubview(button)
    button.setBackgroundImage(
        with(color: .lightGray, alpha: 0.2),
        for: .highlighted
    )
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func tap(callback: @escaping () -> Void) {
    self.tapCallback = callback
    button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
  }
  
  @objc
  func handleTap() {
    tapCallback?()
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    
    button.frame = .init(x: 0, y: 0, width: frame.width, height: frame.height)
    
    let iconSize: CGFloat = 56 * 0.5
    if leftIcon != nil {
      leftIconView.frame = .init(
        x: 16,
        y: (frame.height - iconSize) / 2,
        width: iconSize,
        height: iconSize
      )
    }
    
    let titleStart = leftIcon != nil ? iconSize + 16 : 16
    titleLabel.frame = .init(
      x: titleStart,
      y: 0,
      width: frame.width - 16 - titleStart,
      height: frame.height
    )
  }
  
  deinit {
    //debugPrint("deinit tile")
  }
}
