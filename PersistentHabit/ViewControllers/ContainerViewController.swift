
import UIKit

final class ContainerViewController: UIViewController {

    let start = UIColor(red: 112/255, green: 123/255, blue: 130/255, alpha: 1.0)
    let end = UIColor(red: 54/255, green: 66/255, blue: 70/255, alpha: 1.0)
    private var scrollingViewController:ScrollingViewController!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = GradientView(start: start, end: end)
        gradient.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(gradient, at: 0)
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: view.topAnchor),
            gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        
        loadContent()
    }
    
    private func loadContent() {
        var content = [UIViewController]()
        for i in 1...3 {
            let cardController = CardViewController()
            switch i {
            case 1:
                cardController.chartTitle = "Checkins"
                cardController.chartAdditionalTitle = "23"
                cardController.chartAdditionalSubtitle = "TODAY"
                cardController.chartDateRange = "4 Jan - 3 Feb 2019"
                cardController.resource = Resource<[DataSet]>(fileName: "checkins", fileExtension: "json", type:[DataSet].self)
            case 2:
                cardController.chartTitle = "Total Persistence"
                cardController.chartAdditionalTitle = "90%"
                cardController.chartAdditionalSubtitle = "TODAY"
                cardController.chartDateRange = "March 28 - April 27"
                cardController.resource = Resource<[DataSet]>(fileName: "persistence", fileExtension: "json", type:[DataSet].self)
            case 3:
                cardController.chartTitle = "Check-ins per weekday"
                cardController.roundCorners = [.allCorners]
                cardController.labelTextAlignment = .center
                cardController.shouldDisplayTimeFrame = false
                cardController.resource = Resource<[DataSet]>(fileName: "checkins-weekday", fileExtension: "json", type:[DataSet].self)
            default:break
            }
            
            content.append(cardController)
        }
        
        scrollingViewController = ScrollingViewController(content: content)
        add(child: scrollingViewController)
        
        if let scrollView = scrollingViewController.view {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                ])
        }
    }
}
