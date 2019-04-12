
import UIKit.UIView

final class TimeFrameView: UIView {

    /* API */
    var timeFrame = "" {
        didSet {
            timeFrameLabel.text = timeFrame
            timeFrameLabel.sizeToFit()
        }
    }
    
    private var timeFrameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(white: 1.0, alpha: 0.4)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var leftArrowButton:UIButton =  {
        let button = UIButton(type: .system)
        button.setTitle("<", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var rightArrowButton:UIButton =  {
        let button = UIButton(type: .system)
        button.setTitle(">", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .red
        addSubview(timeFrameLabel)
        addSubview(leftArrowButton)
        addSubview(rightArrowButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timeFrameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            timeFrameLabel.centerXAnchor.constraint(equalTo:centerXAnchor),
            leftArrowButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            leftArrowButton.centerYAnchor.constraint(equalTo: timeFrameLabel.centerYAnchor),
            leftArrowButton.heightAnchor.constraint(equalToConstant: 44),
            leftArrowButton.widthAnchor.constraint(equalToConstant: 44),
            rightArrowButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            rightArrowButton.centerYAnchor.constraint(equalTo: timeFrameLabel.centerYAnchor),
            rightArrowButton.heightAnchor.constraint(equalToConstant: 44),
            rightArrowButton.widthAnchor.constraint(equalToConstant: 44),
            ])
    }
}
