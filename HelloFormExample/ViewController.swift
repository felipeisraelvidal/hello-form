import UIKit
import HelloForm

class ViewController: FormViewController {
    
    private var text = Observable("")
    private var isPrivate = Observable(false)
    
    @Pub private var stepperValue: Double = 2
    @Pub private var stepperValueChangeMode: String = "No value changed"
    
    private var sliderValue: Observable<Float> = Observable(0)
    
    private var testString = Observable("Hello, World!")
    
    private let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    
    @Pub private var isHiddenCustomRow: Bool = false

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
                
                TextRow("Show/Hide")
                    .textColor(.systemBlue)
                    .deselectWhenSelect(true)
                    .addAction {
                        self.isHiddenCustomRow.toggle()
                    }
            }
            
            FormSection(title: "Slider") {
                SliderRow(value: sliderValue, in: 0...100, step: 10) {
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
                        self?.sliderValue.value = Float.random(in: 0...100)
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
                SwitchRow("Is private", isOn: isPrivate)
                    .selectionStyle(.none)
                
                TextFieldRow("Placeholder", text: self.text)
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
                TitleDescriptionRow(title: "Title", description: .right(testString))
                    .textColor(
                        titleLabel: .systemPurple,
                        descriptionLabel: .systemBrown
                    )
                
                TitleDescriptionRow(.subtitle, title: "Title", description: .left(loremIpsum))
                
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
        testString.value = loremIpsum
    }
    
    func addSection() {
        let newSection = FormSection {
            TextRow("Testing...")
        }
        appendSection(newSection)
    }
    
    func addRow() {
        if text.value != "" {
            let newTextRow = TextRow("\(isPrivate.value ? "[L] " : "")\(text.value)")
                .accessoryType(.detailDisclosureButton)
            
            insertRow(newTextRow, atSection: "section_1", at: 0)
            
            self.text.value = ""
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
