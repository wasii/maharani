//
//  DataTableViewCell.swift
//  Derive
//
//  Created by Mac User on 26/05/21.
//  Copyright © 2021 Mac User. All rights reserved.
//

import UIKit
import CoreMedia
protocol TimeSlotCellDelegate : AnyObject {
    func selectedTime(slectedSlot:Int)
}
class TimeSlotCell: UITableViewCell {
    var baseVc :UIViewController?
    @IBOutlet weak var collectionView: IntrinsicCollectionView!
    weak var delegate : TimeSlotCellDelegate?
    var timeSlots: [TimeSlots]?
    var selectedTimeSlot = -1
    var selectedDate = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - Populate Data
    func populateTimeSlots(time : [TimeSlots]?) {
        timeSlots = time
        collectionView.register(UINib.init(nibName: "SlotCollectionViewCell", bundle: Bundle(for: SlotCollectionViewCell.self)), forCellWithReuseIdentifier: "SlotCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
    }
    
}
extension TimeSlotCell: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeSlots?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlotCollectionViewCell", for: indexPath) as? SlotCollectionViewCell else { return UICollectionViewCell() }
        let item = self.timeSlots?[indexPath.row]
        cell.itemLabel.text = item?.time_slot_formated
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //formatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        let someDateTime = formatter.date(from: "\(selectedDate) \(item?.time_slot ?? "" )") ?? Date()
        var currentTime = Date()
        formatter.timeZone = TimeZone.current
        print(formatter.string(from: currentTime))
        
        let diffComponents = Calendar.current.dateComponents([.minute], from: formatter.date(from: formatter.string(from: currentTime)) ?? Date(), to: someDateTime)
        let min = diffComponents.minute ?? 0
        if(item?.available == "1" && min > 1){
            cell.itemLabel.textColor = .black
        }else {
            cell.itemLabel.textColor = .lightGray
        }
        
        if(self.selectedTimeSlot == indexPath.row){
            cell.baseView.layer.borderColor = Color.pink.color().cgColor
            cell.baseView.backgroundColor = Color.pink.color()
            cell.itemLabel.textColor = .white
        }else {
            cell.baseView.layer.borderColor = UIColor.black.cgColor
            cell.baseView.backgroundColor = .clear
        }
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        return cell
    }
    
    
}
extension TimeSlotCell:  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 26)/3.7, height:50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.timeSlots?[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
       // formatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        let someDateTime = formatter.date(from: "\(selectedDate) \(item?.time_slot ?? "" )") ?? Date()
        var currentTime = Date()
        formatter.timeZone = TimeZone.current
        print(formatter.string(from: currentTime))
        
        let diffComponents = Calendar.current.dateComponents([.minute], from: formatter.date(from: formatter.string(from: currentTime)) ?? Date(), to: someDateTime)
        let min = diffComponents.minute ?? 0
        if(item?.available == "1" && min > 1){
            delegate?.selectedTime(slectedSlot: indexPath.row)
        }
    }
    
}
