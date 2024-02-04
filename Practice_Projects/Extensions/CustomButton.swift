import UIKit

class CustomButton: UIButton {
    // The initializer when the button is created programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    // The initializer when the button is created from the storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // Common setup shared by both initializers
    private func commonInit() {
        // Set the initial text color for the normal state
        setTitleColor(.black, for: .normal)
        
        // Add targets for button actions
        addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        addTarget(self, action: #selector(buttonTouchUpInside(_:)), for: .touchUpInside)
        addTarget(self, action: #selector(buttonTouchUpOutside(_:)), for: .touchUpOutside)
    }
    
    // Override isHighlighted property to always return false,
    // preventing the button from showing any highlighting effect
    override var isHighlighted: Bool {
        get {
            return false
        }
        set {}
    }
    
    // The animation when the button is touched down
    @objc private func buttonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            // Scale down the button to 90% of its original size
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    // The animation when the touch is released inside the button
    @objc private func buttonTouchUpInside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            // Return the button to its original size
            sender.transform = CGAffineTransform.identity
        }
        // Perform the action for touchUpInside if needed
    }
    
    // The animation when the touch is released outside the button
    @objc private func buttonTouchUpOutside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            // Return the button to its original size
            sender.transform = CGAffineTransform.identity
        }
    }
}
