import UIKit

final class ViewController: UIViewController {
        
    private let service: ContentService // проверить инициализатор
    
    init(service: ContentServiceProtocol = ContentService(session: FakeNetworkSession())) {
        self.service = service as! ContentService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.service = ContentService(session: FakeNetworkSession())
        super.init(coder: coder)
    }
    
    private var items: [Item] = []
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(ItemCell.self, forCellReuseIdentifier: ItemCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()
        
        service.getItemData() { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let items):
                self.items = items
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
    
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else {
            fatalError("The TableView could not dequeue a ItemCell in ViewController")
        }
        let item = items[indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
}
