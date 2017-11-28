//: Playground - noun: a place where people can play

import Cocoa
import PlaygroundSupport

var str = "Hello, playground"

//var windowController = NSWindowController()
//windowController.window = NSWindow()

//var contentViewController = NSTabViewController()
//contentViewController

//var contentGeneralView = NSTabView()
//var contentAccessibilityView = NSTabView()
//var contentAdvancedView = NSTabView()

//contentGeneralView

class ViewController: NSViewController {
    var tableView: NSTableView!
    var infoLabel: NSTextField!

    func buildUI() {
        func addTable() {
            let tableRect = CGRect(x: 20, y: 115, width: 240, height: 135)
            let tableScrollView = NSScrollView(frame: tableRect)
            self.tableView = NSTableView(frame: tableRect)
            // tableView.delegate = self
            // tableView.dataSource = self
            tableScrollView.documentView = tableView
            view.addSubview(tableScrollView)
        }

        func configureTable() {
            let nameColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "nameColumn"))
            nameColumn.title = "Name"
            nameColumn.minWidth = 100
            tableView.addTableColumn(nameColumn)
            let statusColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "statusColumn"))
            statusColumn.title = "Status"
            statusColumn.minWidth = 130
            tableView.addTableColumn(statusColumn)

            tableView.intercellSpacing = CGSize(width: 5.0, height: 5.0)
            tableView.usesAlternatingRowBackgroundColors = true
        }

        func addInfoLabel() {
            let infoLabelFrame = NSRect(x: 268, y: 228, width: 192, height: 22)
            self.infoLabel = NSTextField(frame: infoLabelFrame)
            view.addSubview(infoLabel)
        }

        addTable()
        configureTable()
        addInfoLabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
}

//let master = NSView(frame: NSMakeRect(0, 0, 500, 500))
//let viewController = ViewController()
//master.addSubview(viewController.view)
//let window = NSWindow()

//PlaygroundPage.current.liveView = master
