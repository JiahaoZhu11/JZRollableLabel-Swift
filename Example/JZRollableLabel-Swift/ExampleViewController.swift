//
//  ExampleViewController.swift
//  JZRollableLabel-Swift
//
//  Created by Jiahao Zhu on 2021/1/5.
//  Copyright (c) 2020 Jiahao Zhu. All rights reserved.
//

import JZRollableLabel_Swift

class ExampleViewController: UIViewController {
    
    private lazy var titleLabel: JZRollableTitleLabel = {
        let label = JZRollableTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seper: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.estimatedRowHeight = 50
        table.separatorInset = UIEdgeInsets.zero
        table.separatorColor = .systemGray
        table.allowsSelection = false
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(titleLabel)
        view.addSubview(seper)
        view.addSubview(table)
        
        let _ = Timer.scheduledTimer(interval: 1, repeats: false) { (timer) in
            timer.invalidate()
        }
        
        titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        seper.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        seper.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        seper.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        seper.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        table.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        table.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        table.topAnchor.constraint(equalTo: seper.bottomAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after the view appeared.
        view.backgroundColor = .white
        
        titleLabel.beginRolling()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ExampleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 22
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = JZRollableLabelCell()
        cell.index = indexPath.row
        switch indexPath.row {
        // MARK: - UILabel Properties Modifying Examples
        case 0:
            cell.demonstratedProperties = ["textColor", "shadowColor", "shadowOffset"]
            cell.label.text = "The title label is positioned with absolute layout, and the following cells is positioned with auto layout. The title label is set to stop rolling after three round of animation. This cell has its textColor, shadowColor and shadowOffset mutated."
            cell.label.textColor = .brown
            cell.label.shadowColor = .lightGray
            cell.label.shadowOffset = CGSize(width: 1, height: 1)
            cell.info = "The title label is positioned with absolute layout, and the following cells is positioned with auto layout. The title label is set to stop rolling after three round of animation. This cell has its textColor, shadowColor and shadowOffset mutated."
            cell.isRolling = true
        case 1:
            cell.demonstratedProperties = ["attributedText"]
            let attrStr = NSMutableAttributedString(string: "This cell is created with setting it attributed text instead of text")
            let attr1: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 10), .foregroundColor: UIColor.systemYellow]
            let attr2: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.systemGreen]
            let attr3: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.systemBlue]
            let oneThird = attrStr.length / 3
            attrStr.addAttributes(attr1, range: NSRange(location: 0, length: oneThird))
            attrStr.addAttributes(attr2, range: NSRange(location: oneThird , length: oneThird))
            attrStr.addAttributes(attr3, range: NSRange(location: 2 * oneThird, length: attrStr.length - 2 * oneThird))
            cell.label.attributedText = attrStr
            cell.info = "This cell is created with setting it attributed text instead of text"
            cell.isRolling = true
        case 2:
            cell.demonstratedProperties = ["textAlignment"]
            cell.label.text = "This cell has its textAllignment set to 'natural' which is the default value. This cell and the following 4 cells' gaps are set to 1 so the differences can be shown."
            cell.info = "This cell has its textAllignment set to 'natural' which is the default value. This cell and the following 4 cells' gaps are set to 1 so the differences can be shown."
            cell.label.textAlignment = .natural
            cell.label.gap = 1
            cell.isRolling = true
        case 3:
            cell.demonstratedProperties = ["textAlignment"]
            cell.label.text = "This cell has its textAllignment set to 'center'."
            cell.info = "This cell has its textAllignment set to 'center'."
            cell.label.textAlignment = .center
            cell.label.gap = 1
            cell.isRolling = true
        case 4:
            cell.demonstratedProperties = ["textAlignment"]
            cell.label.text = "This cell has its textAllignment set to 'left'."
            cell.info = "This cell has its textAllignment set to 'left'."
            cell.label.textAlignment = .left
            cell.label.gap = 1
            cell.isRolling = true
        case 5:
            cell.demonstratedProperties = ["textAlignment"]
            cell.label.text = "This cell has its textAllignment set to 'right'."
            cell.info = "This cell has its textAllignment set to 'right'."
            cell.label.textAlignment = .right
            cell.label.gap = 1
            cell.isRolling = true
        case 6:
            cell.demonstratedProperties = ["textAlignment"]
            cell.label.text = "This cell has its textAllignment set to 'justified'."
            cell.info = "This cell has its textAllignment set to 'justified'."
            cell.label.textAlignment = .justified
            cell.label.gap = 1
            cell.isRolling = true
        case 7:
            cell.demonstratedProperties = ["lineBreakMode"]
            cell.label.text = "This cell has its lineBreakMode set to 'byTruncatingTail' which is the default value. This cell and the following 5 cells' animations are stopped for 1 seconds after each round so the differences can be shown, And it is done using the delegate function 'rollingDidStop(finished flag: Bool)'."
            cell.info = "This cell has its lineBreakMode set to 'byTruncatingTail' which is the default value. This cell and the following 5 cells' animations are stopped for 1 seconds after each round so the differences can be shown, And it is done using the delegate function 'rollingDidStop(finished flag: Bool)'."
            cell.labelLineBreakMode = .byTruncatingTail
            cell.label.delegate = cell
            cell.isRolling = true
        case 8:
            cell.demonstratedProperties = ["lineBreakMode"]
            cell.label.text = "This cell has its lineBreakMode set to 'byTruncatingHead'."
            cell.info = "This cell has its lineBreakMode set to 'byTruncatingHead'."
            cell.labelLineBreakMode = .byTruncatingHead
            cell.label.delegate = cell
            cell.isRolling = true
        case 9:
            cell.demonstratedProperties = ["lineBreakMode"]
            cell.label.text = "This cell has its lineBreakMode set to 'byTruncatingMiddle'."
            cell.info = "This cell has its lineBreakMode set to 'byTruncatingMiddle'."
            cell.labelLineBreakMode = .byTruncatingMiddle
            cell.label.delegate = cell
            cell.isRolling = true
        case 10:
            cell.demonstratedProperties = ["lineBreakMode"]
            cell.label.text = "This cell has its lineBreakMode set to 'byClipping'."
            cell.info = "This cell has its lineBreakMode set to 'byClipping'."
            cell.labelLineBreakMode = .byClipping
            cell.label.delegate = cell
            cell.isRolling = true
        case 11:
            cell.demonstratedProperties = ["lineBreakMode"]
            cell.label.text = "This cell has its lineBreakMode set to 'byCharWrapping'."
            cell.info = "This cell has its lineBreakMode set to 'byCharWrapping'."
            cell.labelLineBreakMode = .byCharWrapping
            cell.label.delegate = cell
            cell.isRolling = true
        case 12:
            cell.demonstratedProperties = ["lineBreakMode"]
            cell.label.text = "This cell has its lineBreakMode set to 'byWordWrapping'."
            cell.info = "This cell has its lineBreakMode set to 'byWordWrapping'."
            cell.labelLineBreakMode = .byWordWrapping
            cell.label.delegate = cell
            cell.isRolling = true
        case 13:
            cell.demonstratedProperties = ["highlightedTextColor", "isHighlighted"]
            cell.label.text = "The highlightedTextColor is set to red and the isHighlighted value is changed every second."
            cell.info = "The highlightedTextColor is set to red and the isHighlighted value is changed every second."
            cell.label.highlightedTextColor = .systemRed
            _ = Timer.scheduledTimer(interval: 1, repeats: true, block: { _ in
                cell.label.isHighlighted = !cell.label.isHighlighted
            })
            cell.isRolling = true
        case 14:
            cell.demonstratedProperties = ["isEnabled"]
            cell.label.text = "\(Date().timeIntervalSince1970)"
            cell.info = "The text is the current time interval which is changing every second and the isEnabled value is changed 5 second. The animations are stopped for 1 seconds after each round so the differences can be shown, And it is done using the delegate function 'rollingDidStop(finished flag: Bool)'. Some of other properties is set to make things more visually friendly."
            cell.label.textAlignment = .center
            _ = Timer.scheduledTimer(interval: 1, repeats: true, block: { _ in
                cell.label.text = "\(Date().timeIntervalSince1970)"
            })
            _ = Timer.scheduledTimer(interval: 5, repeats: true, block: { _ in
                cell.label.isEnabled = !cell.label.isEnabled
            })
            _ = Timer.scheduledTimer(interval: 2, repeats: true, block: { _ in
                cell.isRolling = !cell.isRolling
            })
        // MARK: - JZRollableLabel Properties Modifying Examples
        case 15:
            cell.demonstratedProperties = ["spacing"]
            cell.label.text = "This cell and all the following cells are aiming to demonstrate mutating properties that are unique to JZRollableLabel. This cell has its spacing mutated each round of animation. Remember that the real spacing between the leading and trailing will be the maximum value of spacing value and the distance between the content and the edge from the tailing end of the animation."
            cell.info = "This cell and all the following cells are aiming to demonstrate mutating properties that are unique to JZRollableLabel. This cell has its spacing mutated each round of animation. Remember that the real spacing between the leading and trailing will be the maximum value of spacing value and the distance between the content and the edge from the tailing end of the animation."
            cell.didStopCallback = { (flag) in
                guard flag else { return }
                if cell.label.spacing == 25 {
                    cell.label.spacing = 40
                } else if cell.label.spacing == 40 {
                    cell.label.spacing = 10
                } else {
                    cell.label.spacing = 25
                }
            }
            cell.label.delegate = cell
            cell.isRolling = true
        case 16:
            cell.demonstratedProperties = ["direction"]
            cell.label.text = "This cell has its direction mutated each round of animation."
            cell.info = "This cell has its direction mutated each round of animation."
            cell.didStopCallback = { (flag) in
                guard flag else { return }
                switch cell.label.direction {
                case .leading:
                    cell.label.direction = .trailing
                case .trailing:
                    cell.label.direction = .left
                case .left:
                    cell.label.direction = .right
                case .right:
                    cell.label.direction = .leading
                }
            }
            cell.label.delegate = cell
            cell.isRolling = true
        case 17:
            cell.demonstratedProperties = ["style"]
            cell.label.text = "This cell has its style mutated each round of animation. However, rollign is the only supporting animation style at this time XD."
            cell.info = "This cell has its style mutated each round of animation. However, rollign is the only supporting animation style at this time XD."
//            cell.didStopCallback = { (flag) in
//                guard flag else { return }
//                switch cell.label.style {
//                case .rolling:
//                    <#code#>
//                }
//            }
            cell.label.delegate = cell
            cell.isRolling = true
        case 18:
            cell.demonstratedProperties = ["speed"]
            cell.label.text = "This cell has its speed mutated each round of animation."
            cell.info = "This cell has its speed mutated each round of animation."
            cell.didStopCallback = { (flag) in
                guard flag else { return }
                switch cell.label.speed {
                case 1:
                    cell.label.speed = 5
                case 5:
                    cell.label.speed = 0.2
                default:
                    cell.label.speed = 1
                }
            }
            cell.label.delegate = cell
            cell.isRolling = true
        case 19:
            cell.demonstratedProperties = ["duration"]
            cell.label.text = "The duration property is a read-only property. One good usage of it is to stop the animation after a certain amount of rounds combining with the delegate function 'rollingDidStart()'. The rolling animation of this cell is stopped for 1 second every 3 rounds of animation. Another good usage is shown as in cell #21."
            cell.info = "The duration property is a read-only property. One good usage of it is to stop the animation after a certain amount of rounds combining with the delegate function 'rollingDidStart()'. The rolling animation of this cell is stopped for 1 second every 3 rounds of animation. Another good usage is shown as in cell #21."
            cell.didStartCallback = {
                guard cell.timer == nil else { return }
                cell.timer = Timer.scheduledTimer(interval: cell.label.duration * 3, repeats: false, block: { (timer) in
                    cell.isRolling = false
                    cell.timer = Timer.scheduledTimer(interval: 1, repeats: false, block: { (timer) in
                        cell.isRolling = true
                        timer.invalidate()
                        cell.timer = nil
                    })
                    timer.invalidate()
                })
            }
            cell.label.delegate = cell
            cell.isRolling = true
        case 20:
            cell.demonstratedProperties = ["gap"]
            cell.label.text = "This cell has its gap mutated each round of animation."
            cell.info = "This cell has its gap mutated each round of animation."
            cell.didStopCallback = { (flag) in
                guard flag else { return }
                switch cell.label.gap {
                case 0:
                    cell.label.gap = 1
                case 1:
                    cell.label.gap = 3
                default:
                    cell.label.gap = 0
                }
            }
            cell.label.delegate = cell
            cell.isRolling = true
        case 21:
            cell.demonstratedProperties = ["delegate", "duration", "speed"]
            cell.label.text = "The delegate property is used to set up function that is call while the animation is began, ended or stopped. The cell's gap is set to 1 second is stopped every 8.5 seconds and began after 1 second and the status, which is a read-only property, is displayed at the end of the info section. This is also a good example of using the duration and the speed properties to make a fixed duration for the animation, no matter how long the label is. The duration of this cell is set to 5 seconds per round."
            cell.info = "The delegate property is used to set up function that is call while the animation is began, ended or stopped. The cell's gap is set to 1 second is stopped every 8.5 seconds and began after 1 second and the status, which is a read-only property, is displayed at the end of the info section. This is also a good example of using the duration and the speed properties to make a fixed duration for the animation, no matter how long the label is. The duration of this cell is set to 5 seconds per round. Status:\(cell.label.status)"
            cell.label.speed = Float(cell.label.duration / 5)
            cell.label.gap = 1
            cell.didStartCallback = {
                cell.info = "The delegate property is used to set up function that is call while the animation is began, ended or stopped. The cell's gap is set to 1 second is stopped every 8.5 seconds and began after 1 second and the status, which is a read-only property, is displayed at the end of the info section. This is also a good example of using the duration and the speed properties to make a fixed duration for the animation, no matter how long the label is. The duration of this cell is set to 5 seconds per round. Status:\(cell.label.status)"
                guard cell.timer == nil else { return }
                cell.timer = Timer.scheduledTimer(interval: 8.5, repeats: false, block: { (timer) in
                    cell.isRolling = false
                    cell.timer = Timer.scheduledTimer(interval: 1, repeats: false, block: { (timer) in
                        cell.isRolling = true
                        timer.invalidate()
                        cell.timer = nil
                    })
                    timer.invalidate()
                })
            }
            cell.didStopCallback = { _ in
                cell.info = "The delegate property is used to set up function that is call while the animation is began, ended or stopped. The cell's gap is set to 1 second is stopped every 8.5 seconds and began after 1 second and the status, which is a read-only property, is displayed at the end of the info section. This is also a good example of using the duration and the speed properties to make a fixed duration for the animation, no matter how long the label is. The duration of this cell is set to 5 seconds per round. Status:\(cell.label.status)"
            }
            cell.label.delegate = cell
            cell.isRolling = true
        default:
            break
        }
        return cell
    }
    
}

fileprivate class JZRollableTitleLabel: UIView {
    
    private var timer: Timer?
    
    private lazy var label: JZRollableLabel = {
        let label = JZRollableLabel()
        label.text = "JZRollableLabel - A label control that can roll while displaying infomation."
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let ges = UITapGestureRecognizer(target: self, action: #selector(gesAction))
        addGestureRecognizer(ges)
        
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = bounds
    }
    
    public func beginRolling() {
        timer?.invalidate()
        timer = nil
        label.beginRolling()
        timer = Timer.scheduledTimer(interval: label.duration * 3, repeats: false) { [weak self] (timer) in
            self?.label.stopRolling(immediately: true)
            timer.invalidate()
        }
    }
    
    @objc private func gesAction() {
        beginRolling()
    }
    
}


fileprivate class JZRollableLabelCell: UITableViewCell {
    
    public var isRolling: Bool = false {
        didSet {
            if isRolling {
                label.beginRolling()
            } else {
                label.stopRolling(immediately: true)
            }
        }
    }
    
    public var index: Int = 0 {
        didSet {
            updateTitle()
        }
    }
    
    public var demonstratedProperties: [String] = [] {
        didSet {
            updateTitle()
        }
    }
    
    public var info: String? {
        set {
            infoLabel.text = newValue
        }
        get {
            return infoLabel.text
        }
    }
    
    public var labelLineBreakMode: NSLineBreakMode {
        set {
            label.lineBreakMode = newValue
            isLineBreakModeExampleCell = true
        }
        get {
            return label.lineBreakMode
        }
    }
    
    private var isLineBreakModeExampleCell: Bool = false
    
    public var didStartCallback: (() -> ())?
    
    public var timer: Timer?
    
    public var didStopCallback: ((_ flag: Bool) -> ())?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var label: JZRollableLabel = {
        let label = JZRollableLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(label)
        addSubview(infoLabel)
        
        layoutUI()
    }
    
    private func layoutUI() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        infoLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        infoLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    private func updateTitle() {
        var text = "#\(index). The demonstrated properties are: "
        for property in demonstratedProperties {
            text += property
            if property != demonstratedProperties.last {
                text += ", "
            }
        }
        titleLabel.text = text
    }
    
}

extension JZRollableLabelCell: JZRollableLabelDelegate {
    
    func rollingDidStart() {
        didStartCallback?()
    }
    
    func rollingDidStop(finished flag: Bool) {
        didStopCallback?(flag)
        if isLineBreakModeExampleCell, flag {
            isRolling = false
            _ = Timer.scheduledTimer(interval: 3, repeats: false, block: { [weak self] (timer) in
                self?.isRolling = true
                timer.invalidate()
            })
        }
    }
    
}

// MARK: - Timer Easy Generator
fileprivate extension Timer {

    class func scheduledTimer(interval: TimeInterval, repeats: Bool, block: @escaping ((_ timer: Timer) -> ())) -> Timer {
        if #available(iOS 10.0, *) {
            return Timer.scheduledTimer(withTimeInterval: interval,
                                        repeats: repeats,
                                        block: block)
        } else {
            return Timer.scheduledTimer(timeInterval: interval,
                                        target: self,
                                        selector: #selector(action(timer:)),
                                        userInfo: block,
                                        repeats: repeats)
        }
    }

    @objc private class func action(timer: Timer) {
        guard let block = timer.userInfo as? ((Timer) -> ()) else {
            return
        }
        block(timer);
    }

}

