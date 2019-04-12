
import UIKit

final class GradientView: UIView {

    var startColor:UIColor = .white
    var endColor:UIColor = .blue
    
    convenience init(start:UIColor, end:UIColor){
        self.init()
        startColor = start
        endColor = end
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override class var layerClass:AnyClass{
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [startColor.cgColor, endColor.cgColor]
    }

}
