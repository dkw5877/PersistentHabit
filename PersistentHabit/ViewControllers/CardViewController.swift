
import UIKit

final class CardViewController: UIViewController {
    
    /* public api */
    var chartTitle:String = "" {
        didSet {
            leftTitleLabel.text = chartTitle
            leftTitleLabel.sizeToFit()
        }
    }
    
    var chartSubtitle = "" {
        didSet {
            leftSubtitleLabel.text = chartSubtitle
            leftSubtitleLabel.sizeToFit()
        }
    }
    
    var chartAdditionalTitle:String = "" {
        didSet {
            rightTitleLabel.text = chartAdditionalTitle
            rightTitleLabel.sizeToFit()
        }
    }
    
    var chartAdditionalSubtitle = "" {
        didSet {
            rightSubtitleLabel.text = chartAdditionalSubtitle
            rightSubtitleLabel.sizeToFit()
        }
    }
    
    var progress = "" {
        didSet {
            progressLabel.text = progress
        }
    }
    
    var chartDateRange = "" {
        didSet {
            timeFrameView.timeFrame = chartDateRange
        }
    }
    
    var labelTextAlignment:CATextLayerAlignmentMode = .left {
        didSet {
            graphView.labelTextAlignment = labelTextAlignment
            graphView.setNeedsDisplay()
        }
    }
    
    var roundCorners:UIRectCorner = [.topLeft, .topRight] {
        didSet {
            graphView.roundCorners = roundCorners
            graphView.setNeedsDisplay()
        }
    }
    
    var shouldDisplayTimeFrame:Bool = true
    
    var resource:Resource<[DataSet]>?
    
    /* private data */
    private var leftTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var leftSubtitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(white: 1.0, alpha: 0.6)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var rightTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var rightSubtitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(white: 1.0, alpha: 0.6)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var progressBar:UIProgressView = {
        let progress = UIProgressView()
        progress.tintColor = UIColor(red: 73/255, green: 123/255, blue: 45/255, alpha: 1.0)
        progress.progress = 1.0
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    private var progressLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.backgroundColor = UIColor(red: 73/255, green: 123/255, blue: 45/255, alpha: 1.0)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.layer.cornerRadius = 25/2.0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        return label
    }()
    
    private var graphView: GraphView = {
        let graphView = GraphView()
        graphView.translatesAutoresizingMaskIntoConstraints = false
        graphView.backgroundColor = .clear
        return graphView
    }()
    
    private lazy var timeFrameView:TimeFrameView = {
        let view = TimeFrameView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    var dataItems = [DataItem]()
    
    private var progressViewTopConstraint:NSLayoutConstraint!
    private var progressLabelWidthConstraint:NSLayoutConstraint!
    private var graphViewHeightConstraint:NSLayoutConstraint!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.60)
        view.addSubview(leftTitleLabel)
        view.addSubview(leftSubtitleLabel)
        view.addSubview(rightTitleLabel)
        view.addSubview(rightSubtitleLabel)
        view.addSubview(graphView)
        view.addSubview(progressBar)
        view.addSubview(progressLabel)
        
        /* store the progress view's anchor so it can me adjusted accordingly */
        progressViewTopConstraint = progressBar.topAnchor.constraint(equalTo: graphView.topAnchor, constant: -10)
        progressViewTopConstraint.isActive = true
        
        progressLabelWidthConstraint = progressLabel.widthAnchor.constraint(equalToConstant: 25)
        progressLabelWidthConstraint.isActive = true
        
        graphViewHeightConstraint = graphView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.60)
        
        graphViewHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            leftTitleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            leftTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            leftSubtitleLabel.topAnchor.constraint(equalTo:leftTitleLabel.bottomAnchor, constant: 4),
            leftSubtitleLabel.leadingAnchor.constraint(equalTo: leftTitleLabel.leadingAnchor),
            rightTitleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16),
            rightTitleLabel.centerYAnchor.constraint(equalTo:leftTitleLabel.centerYAnchor),
            rightSubtitleLabel.trailingAnchor.constraint(equalTo: rightTitleLabel.trailingAnchor),
            rightSubtitleLabel.centerYAnchor.constraint(equalTo:leftSubtitleLabel.centerYAnchor),
            ])
        
        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            progressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progressLabel.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor),
            progressLabel.heightAnchor.constraint(equalToConstant: 25),
            graphView.topAnchor.constraint(equalTo:leftSubtitleLabel.bottomAnchor, constant: 32),
            graphView.leadingAnchor.constraint(equalTo: leftTitleLabel.leadingAnchor),
            graphView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -8),
            ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 15
        importData()
        if shouldDisplayTimeFrame {
            configureTimeFrameView()
        }
    }
    
    private func configureTimeFrameView() {
        timeFrameView.setNeedsLayout()
        view.addSubview(timeFrameView)
        
        graphViewHeightConstraint.isActive = false
        NSLayoutConstraint.activate([
            graphView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            timeFrameView.topAnchor.constraint(equalTo: graphView.bottomAnchor, constant: 16),
            timeFrameView.leadingAnchor.constraint(equalTo: graphView.leadingAnchor),
            timeFrameView.trailingAnchor.constraint(equalTo: graphView.trailingAnchor),
            ])
    }
    
    private func importData() {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            if let resource = self.resource {
                FileLoadingService().load(resource: resource, completion: { (result) in
                    
                    guard let apiData = result else { return }
                    let dataSet = apiData[0]
                    self.dataItems = dataSet.data
                    let data = self.dataItems.map{ $0.value }
                    let labels = self.dataItems.map{ $0.day }
                    var filteredLabels = [String]()
                    
                    if labels.count > 7 {
                        for (index, label) in labels.enumerated() {
                            if index % 3 == 0 {
                                filteredLabels.append(label)
                            }
                        }
                    } else {
                        filteredLabels = labels
                    }
                    
                    DispatchQueue.main.async {
                        self.graphView.data = data
                        self.graphView.labels = filteredLabels
                        self.progress = "\(dataSet.status)"
                        if self.progress.count > 2 {
                            self.progressLabelWidthConstraint.constant = 35
                        }
                        
                        if dataSet.average > 0 {
                            self.chartSubtitle = "DAILY AVERAGE: \(dataSet.average)"
                        }
                    }
                })
            }
        }
    }
}

