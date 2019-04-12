
import UIKit.UIView

final class GraphView: UIView {
    
    var data:[Int] = [] {
        didSet {
            drawDataPoints()
        }
    }
    
    var labels:[String] = [] {
        didSet {
         drawDataLabels()
        }
    }
    
    var labelTextAlignment:CATextLayerAlignmentMode = .left
    
    var barColor = UIColor(red: 118/255, green: 208/255, blue: 98/255, alpha: 1.0)
    
    var endcapSize = CGSize(width: 10, height: 10)
    
    var roundCorners:UIRectCorner = [.topLeft, .topRight]
    
    override func layoutSublayers(of layer: CALayer) {
        if let isEmpty = layer.sublayers?.isEmpty {
            if !isEmpty {
                layer.sublayers?.removeAll()
                drawDataPoints()
                drawDataLabels()
            }
        }
    }
    
    private func drawDataPoints() {

        guard !data.isEmpty else { return }
        
        let numberOfColumns = data.count
        let halfWidth = frame.width / 2
        let columnWidth = halfWidth / CGFloat(numberOfColumns)
        
        for i in 0...(numberOfColumns - 1) {
            let columnLayer = CAShapeLayer()
            columnLayer.fillColor = barColor.cgColor
            columnLayer.strokeColor = barColor.cgColor
            columnLayer.lineCap = .round
            let columnHeight:CGFloat = normalizedHeight()
            let height = frame.height
            let rect = CGRect(x: CGFloat(i) * (2 * columnWidth), y: height - columnHeight, width: columnWidth, height: columnHeight)
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: roundCorners, cornerRadii: endcapSize)
            columnLayer.path = path.cgPath
            layer.addSublayer(columnLayer)
        }
    }
    
    private func drawDataLabels() {
        
        guard !labels.isEmpty else { return }
        
        let numberOfColumns = data.count
        let numberOfLabels = labels.count
        let halfWidth = frame.width / 2
        let columnWidth = halfWidth / CGFloat(numberOfColumns)
        let labelWidth = halfWidth / CGFloat(numberOfLabels)
        
         /* double the number of  columns to account for space between columns */
        let ratio = ceil(CGFloat(2 * numberOfColumns)/CGFloat(numberOfLabels))
        let spacing = CGFloat(ratio) * columnWidth
        
        for i in 0...(numberOfLabels - 1) {
            let label = labels[i]
            drawDataLabel(title: label, position: i, spacing:spacing, labelWidth: labelWidth, labelHeight: 20)
        }
    }
    
    private func drawDataLabel(title:String, position:Int, spacing:CGFloat, labelWidth:CGFloat, labelHeight:CGFloat) {
        let textLayer = CATextLayer()
        textLayer.alignmentMode = labelTextAlignment
        textLayer.fontSize = 10
        textLayer.foregroundColor = UIColor(white: 1, alpha: 0.6).cgColor
        textLayer.string = title
        let height = frame.height
        textLayer.frame = CGRect(x: CGFloat(position) * spacing, y: height, width:labelWidth , height: labelHeight)
        layer.addSublayer(textLayer)
    }
    
    private func normalizedHeight() -> CGFloat {
        let max = data.max()
        guard let maxValue = max else { return 0 }
        let randomHeight = Int.random(in: 1...maxValue)
        let height = frame.height
        let increment = height / CGFloat(maxValue)
        let actualheight = CGFloat(randomHeight) * increment
        return actualheight
    }

}
