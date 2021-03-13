import Foundation
import UIKit

private let checkIcon = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAQAAAD9CzEMAAAApklEQVRYhe3NOw6CUBhE4dPRSkHvAgyNK2EZ1jY+YXNWrMIeV6DGa0OUp4nhTkTyTz/fAZvNZpvWFuRcWKn4mAKH406k5EWBN+/Yavnsr/nU+J/xx9HxcwIdH3DCcSbW8JCU16InUeUP3/Ow5PEhMZgHSF9EM+GFB8g6E9747kSV3w/l2wnvfDMh4OsJCd9O7Hzz9YSEB9hw48paxQOEzJS8zWYb/54xPa/oTp4wKAAAAABJRU5ErkJggg=="

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

let data = try! Data(contentsOf: URL(string: checkIcon)!)
let checkIconImage = UIImage(data: data)

public class ListTileView: UIView {
    var tapCallback: (() -> Void)?

    var checked = false {
        didSet {
            rightIconView.isHidden = !checked
            layoutSubviews()
        }
    }
    
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
    
    public lazy var rightIconView: UIImageView = {
        let imageView = UIImageView(image: checkIconImage)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.isHidden = true
        return imageView
    }()
    
    let button = UIButton()
    
    public init(title: String) {
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
        
        if checked {
            if rightIconView.superview == nil {
                addSubview(rightIconView)
            }
            rightIconView.frame = .init(
                x: frame.width - 16 - iconSize,
                y: (frame.height - iconSize) / 2,
                width: iconSize,
                height: iconSize
            )
        }
        
        let titleStart = leftIcon != nil ? iconSize + 16 : 16
        let checkedSize = checked ? iconSize : 0
        titleLabel.frame = .init(
            x: titleStart,
            y: 0,
            width: frame.width - 16 - titleStart - checkedSize - 16,
            height: frame.height
        )
    }
    
    deinit {
        //debugPrint("deinit tile")
    }
}
