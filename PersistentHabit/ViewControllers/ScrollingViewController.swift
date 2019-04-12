
import UIKit

final class ScrollingViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let scrollViewContentContainer = UIView()
    private var contents = [UIViewController]()
    private var cardHeight: CGFloat = 300
    private var margin: CGFloat = 8
    private var spacing: CGFloat = 10
    
    init(content: [UIViewController]) {
        contents = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        scrollView.backgroundColor = UIColor.clear
        scrollView.preservesSuperviewLayoutMargins = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: scrollView.topAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (index, content) in contents.enumerated() {
            add(child: content, in: scrollView)
            content.view.translatesAutoresizingMaskIntoConstraints = false

            if index == 0 {
                NSLayoutConstraint.activate([
                    content.view.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: spacing),
                    content.view.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: margin),
                    content.view.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -margin * 2),
                    content.view.heightAnchor.constraint(equalToConstant: cardHeight),
                    ])
            } else {
                let previous = contents[index-1]
                NSLayoutConstraint.activate([
                    content.view.topAnchor.constraint(equalTo: previous.view.safeAreaLayoutGuide.bottomAnchor, constant: spacing),
                    content.view.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: margin),
                    content.view.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -margin * 2),
                    content.view.heightAnchor.constraint(equalToConstant: cardHeight),
                    ])
            }
        }
         /* pin the last view to scrollview bottom */
        if let last = contents.last {
            NSLayoutConstraint.activate([
                last.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -spacing),
                ])
        }
    }
}
