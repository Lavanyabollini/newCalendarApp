//
//  ViewController.swift
//  NewCalendarApp
//
//  Created by mobinius on 18/12/17.
//  Copyright © 2017 mobinius. All rights reserved.
//

import UIKit
import JTAppleCalendar
class ViewController: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    
    let outsideMonthColor = UIColor(red: 169/255, green:169/255, blue:169/255, alpha: 1.0) 
    let monthColor = UIColor.white
    let selectedMonthColor = UIColor.black
    let currentDateSelectedViewColor = UIColor.yellow
    
    let formatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
       setupCalendarView()
    }

    func setupCalendarView()
    {
        //set up calendar spacing
        calendarView.minimumLineSpacing=0
        calendarView.minimumInteritemSpacing=0
        //setup labels
        calendarView.visibleDates{(visibleDates)in
            let date = visibleDates.monthDates.first!.date
            self.formatter.dateFormat = "yyyy"
            self.year.text = formatter.string(from: date)
            self.formatter.dateFormat = "MMMM"
            self.month.text = self.formatter.string(from: date)
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleCelltextColor(view:JTAppleCell?, cellState:CellState){
        guard let validCell = view as? CustomCell else {
            return
        }
        if cellState.isSelected{
            validCell.dateLabel.textColor = selectedMonthColor
        }else{
            if cellState.dateBelongsTo == .thisMonth{
                validCell.dateLabel.textColor = monthColor
            }else{
                validCell.dateLabel.textColor = outsideMonthColor

            }
            validCell.selectedView.isHidden=true
        }
    }
    func handleCellSelected(view:JTAppleCell?, cellState:CellState){
        guard let validCell = view as? CustomCell else {
            return
        }
        if cellState.isSelected{
            validCell.selectedView.isHidden=false
        }else{
            validCell.selectedView.isHidden=true
        }
}
}
extension ViewController:JTAppleCalendarViewDataSource{
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
   
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = formatter.date(from: "2018 12 31" )!
        let parameters=ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    
}
extension ViewController:JTAppleCalendarViewDelegate{
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath)as! CustomCell
        cell.dateLabel.text = cellState.text
        handleCellSelected(view:cell, cellState:cellState)
        handleCelltextColor(view:cell, cellState:cellState)
        return cell
    }
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view:cell, cellState:cellState)
        handleCelltextColor(view:cell, cellState:cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
    
        handleCellSelected(view:cell, cellState:cellState)
        handleCelltextColor(view:cell, cellState:cellState)
    }
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        formatter.dateFormat = "yyyy"
        year.text = formatter.string(from: date)
        formatter.dateFormat = "MMMM"
        month.text = formatter.string(from: date)
        
    }
}
extension UIColor {
//    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
//        self.init(
//            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(value & 0x0000FF) / 255.0,
//            alpha: alpha
//        )
//    }
}
