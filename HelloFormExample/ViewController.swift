import UIKit
import HelloForm

class ViewController: FormViewController {
    
    @Pub private var text = ""
    @Pub private var isPrivate = false
    
    @Pub private var stepperValue: Double = 2
    @Pub private var stepperValueChangeMode: String = "No value changed"
    
    @Pub private var sliderValue: Float = 0
    
    @Pub private var testString: String = "Hello, World!"
    
    private let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    
    @Pub private var isHiddenCustomRow: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Form"
        
        view.backgroundColor = .systemBackground
        
        let shouldShowExperimental = true
        
        let arr = [
            "Item 1",
            "Item 2",
            "Item 3"
        ]
        
        makeSections {
            FormSection {
                CustomRow {
                    HStack(alignment: .center, distribution: .fillEqually, spacing: 16) {
                        UIView()
                            .setBackgroundColor(.systemBlue)
                            .setHeight(50)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            UILabel("Hello, World!")
                            
                            UILabel("Hello, World! 2")
                                .setTextColor(.white)
                        }
                        .setBackgroundColor(.systemPurple)
                    }
                    .setBackgroundColor(.systemRed)
                    .fillSuperview(offset: 0)
                    .setHeight(80)
                }
                .hidden($isHiddenCustomRow)
                .tag("testing_hidden_row")
                .reloadRowAnimation(.fade)
                
                TextRow("Show/Hide")
                    .font(.preferredFont(forTextStyle: .body))
                    .textColor(.systemBlue)
                    .deselectWhenSelect(true)
                    .addAction {
                        self.isHiddenCustomRow.toggle()
                    }
            }
            
            FormSection(title: "Slider") {
                SliderRow(value: $sliderValue, in: 0...100, step: 10) {
                    UILabel("100")
                } minimumValueLabel: {
                    UILabel("0")
                }
                .selectionStyle(.none)
                
                TextRow("Slider value")
                    .selectionStyle(.none)
                
                TextRow("Set custom value")
                    .textColor(.systemBlue)
                    .addAction { [weak self] in
                        self?.sliderValue = Float.random(in: 0...100)
                    }
                    .deselectWhenSelect(true)
            }
            
            FormSection(title: "Stepper") {
                StepperRow("Stepper", value: $stepperValue, in: 0...5) {
                    self.stepperValueChangeMode = "Increment"
                } onDecrement: {
                    self.stepperValueChangeMode = "Decrement"
                }
                
                TextRow($stepperValueChangeMode)
                    .reloadRowAnimation(.none)
                
                TextRow("Set Minimum Value")
                    .textColor(.systemBlue)
                    .addAction { [weak self] in
                        self?.stepperValue = 0
                    }
                    .deselectWhenSelect(true)
            }
            
            FormSection(footer: "Enter your text and tap enter to add new item") {
                SwitchRow("Is private", isOn: $isPrivate)
                    .selectionStyle(.none)
                
                TextFieldRow("Placeholder", text: $text)
                    .font(.preferredFont(forTextStyle: .title2))
                    .onSubmit { [weak self] _ in
                        self?.addRow()
                    }
                    .autocapitalizationType(.sentences)
                    .clearButtonMode(.whileEditing)
                    .returnKeyType(.done)
                    .selectionStyle(.none)
                    .padding(top: 16, bottom: 16)
                
                TextRow("Add Item")
                    .textColor(.systemBlue)
                    .deselectWhenSelect(true)
                    .addAction { [weak self] in
                        self?.addRow()
                    }
            }
            
            FormSection("section_1") {
                for item in arr {
                    TextRow(item)
                        .accessoryType(.detailDisclosureButton)
                        .addAction {
                            self.showNextViewController()
                        }
                        .addDetailDisclosureButtonAction {
                            print(item)
                        }
                }
            }

            if shouldShowExperimental {
                FormSection(title: "Section 1", footer: "Lorem Ipsum") {
                    TextRow(loremIpsum, image: .init(systemName: "iphone"))
                        .textColor(.systemRed)
                        .accessoryType(.disclosureIndicator)
                        .deselectWhenSelect(true)
                    
                    TextRow("Row 1")
                        .selectionStyle(.none)
                    
                    TextRow("Row 1")
                }
            }

            FormSection(footer: loremIpsum) {
                TitleDescriptionRow(title: "Title", description: $testString)
                    .textColor(
                        titleLabel: .systemPurple,
                        descriptionLabel: .systemBrown
                    )
                
                TitleDescriptionRow(.subtitle, title: "Title", description: loremIpsum)
                
                TextRow("Reload First Cell")
                    .textColor(.systemBlue)
                    .deselectWhenSelect(true)
                    .addAction { [weak self] in
                        self?.updateFirstCell()
                    }
            }
            
            FormSection {
                let swiftSymbol = UIImage.init(systemName: "swift")
                
                TextRow("Add New Section", image: swiftSymbol)
                    .textColor(.systemBlue)
                    .deselectWhenSelect(true)
                    .addAction { [weak self] in
                        self?.addSection()
                    }
            }
        }
    }
    
    func updateFirstCell() {
        testString = loremIpsum
    }
    
    func addSection() {
        let newSection = FormSection {
            TextRow("Testing...")
        }
        appendSection(newSection)
    }
    
    func addRow() {
        if text != "" {
            let newTextRow = TextRow("\(isPrivate ? "[L] " : "")\(text)")
                .accessoryType(.detailDisclosureButton)
            
            insertRow(newTextRow, atSection: "section_1", at: 0)
            
            self.text = ""
        }
    }
    
    func showNextViewController() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemRed
        navigationController?.pushViewController(viewController, animated: true)
    }

}

#if DEBUG
import SwiftUI
struct ViewControllerPreviews: PreviewProvider {
    
    static var previews: some View {
        ContainerPreview()
            .ignoresSafeArea()
    }
    
    struct ContainerPreview: UIViewControllerRepresentable {
        typealias UIViewControllerType = UINavigationController
        
        func makeUIViewController(context: Context) -> UIViewControllerType {
            let viewController = ViewController()
            
            let navigationController = UINavigationController(rootViewController: viewController)
            
            return navigationController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
    
}
#endif
