import UIKit

class MergingView: UIView {

    let borderLayer = CALayer()
    let backgroundLayer = CALayer()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        
        borderLayer.borderWidth = 5
        borderLayer.frame = frame
        borderLayer.zPosition = 10
        borderLayer.borderColor = UIColor.black.cgColor
        superview?.layer.addSublayer(borderLayer)
        
        backgroundLayer.frame = CGRect(x: frame.origin.x + 5, y: frame.origin.y + 5, width: frame.width - 10, height: frame.height - 10)
        backgroundLayer.zPosition = 20
        backgroundLayer.backgroundColor = UIColor.white.cgColor
        superview?.layer.addSublayer(backgroundLayer);
    }
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        
        let translation = recognizer.translation(in: self)
        frame = self.frame.offsetBy(dx: translation.x, dy: translation.y)
        recognizer.setTranslation(CGPoint.zero, in: self)
        
        borderLayer.frame = borderLayer.frame.offsetBy(dx: translation.x, dy: translation.y)
        backgroundLayer.frame = backgroundLayer.frame.offsetBy(dx: translation.x, dy: translation.y)
        
        CATransaction.commit()
    }
}
