//
//  ViewController.swift
//  TipCalculator


import UIKit

class ViewController: UIViewController {

    // MARK: - View Lifecycle
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    
    @IBOutlet weak var inputCardView: UIView!
    @IBOutlet weak var billAmountTextField: BillAmountTextField!
    @IBOutlet weak var tipPercentSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var outputCardView: UIView!
    @IBOutlet weak var tipAmountTitleLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountTitleLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    var isDefaultStatusBar = true

       // 2
       override var preferredStatusBarStyle: UIStatusBarStyle {
           return isDefaultStatusBar ? .default : .lightContent
       }
    
    
    
    
    func calculate() {
        billAmountTextField.calculateButtonAction = {
            // dismiss keyboard if it's displayed
            if self.billAmountTextField.isFirstResponder {
                self.billAmountTextField.resignFirstResponder()
            }
            
            
            guard let billAmountText = self.billAmountTextField.text,
                let billAmount = Double(billAmountText)
                else {
                    self.clear()
                    return
            }
            
            let roundedBillAmount = (billAmount * 100).rounded() / 100
            
            let tipPercentages = [0.15, 0.18, 0.2]
            let tipPercent = tipPercentages[self.tipPercentSegmentedControl.selectedSegmentIndex]
            
            let tipAmount = roundedBillAmount * tipPercent
            let totalAmount = roundedBillAmount + tipAmount
            
            // update UI
            self.billAmountTextField.text = String(format: "$%.2f", roundedBillAmount)
            self.tipAmountLabel.text = String(format: "$%.2f", tipAmount)
            self.totalAmountLabel.text = String(format: "$%.2f", totalAmount)
            
        }
    }
    
    func clear(){
        billAmountTextField.text = nil
        tipPercentSegmentedControl.selectedSegmentIndex = 0
        tipAmountLabel.text = "$0.00"
        totalAmountLabel.text = "$0.00"
    }
    
    func setUpViews() {
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        headerView.layer.shadowOpacity = 0.05
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowRadius = 35
        
        inputCardView.layer.cornerRadius = 8
        inputCardView.layer.masksToBounds = true
        
        outputCardView.layer.cornerRadius = 8
        outputCardView.layer.masksToBounds = true
        outputCardView.layer.borderWidth = 1
         outputCardView.layer.borderColor = UIColor.tcSeafoamGreen.cgColor
        
        resetButton.layer.cornerRadius = 8
        resetButton.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setTheme(isDark: false)
        calculate()
    }
    
    func setTheme(isDark: Bool){
        let theme = isDark ? ColorTheme.dark : ColorTheme.light

        view.backgroundColor = theme.viewControllerBackgroundColor

        headerView.backgroundColor = theme.primaryColor
        titleLabel.textColor = theme.primaryTextColor

        inputCardView.backgroundColor = theme.secondaryColor

        billAmountTextField.tintColor = theme.accentColor
        tipPercentSegmentedControl.tintColor = theme.accentColor

        outputCardView.backgroundColor = theme.primaryColor
        outputCardView.layer.borderColor = theme.accentColor.cgColor

        tipAmountTitleLabel.textColor = theme.primaryTextColor
        totalAmountTitleLabel.textColor = theme.primaryTextColor

        tipAmountLabel.textColor = theme.outputTextColor
        totalAmountLabel.textColor = theme.outputTextColor

        resetButton.backgroundColor = theme.secondaryColor
        
        isDefaultStatusBar = theme.isDefaultStatusBar
        setNeedsStatusBarAppearanceUpdate()
        
    }
    
    @IBAction func themeToggled(_ sender: UISwitch) {
        setTheme(isDark: sender.isOn)
        
    }
    
    @IBAction func tipPercentChanged(_ sender: UISegmentedControl) {
        calculate()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        clear()
    }
    
   
}

