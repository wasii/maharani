//
//  DateSlotCell.swift
//  Maharani
//
//  Created by Zain on 12/01/2022.
//

import UIKit
protocol DateSlotCellDelegate : AnyObject {
    func selectedDate(selectedDate:String)
}
class DateSlotCell: UITableViewCell {
    weak var delegate : DateSlotCellDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedDate = ""
    var arrDatesInGivenMonthYear = [Date]()
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionView()
    }
    //MARK: - UI
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "DateCollectionCell", bundle: nil), forCellWithReuseIdentifier: "DateCollectionCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 5
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.collectionView.collectionViewLayout = layout
    }
    func setInterface() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: self.selectedDate) else {
            return
        }
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date)
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date)
        arrDatesInGivenMonthYear.removeAll()
        arrDatesInGivenMonthYear = getAllDates(month: Int(month)!, year: Int(year)!)
        if arrDatesInGivenMonthYear.count == 0 {
           return
        }
        collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if( Int(day)! < self.arrDatesInGivenMonthYear.count){
            self.collectionView.selectItem(at: IndexPath(row: Int(day)!, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            }
        }
    }
    func removeAllDates() {
        arrDatesInGivenMonthYear.removeAll()
        collectionView.reloadData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func getAllDates(month: Int, year: Int) -> [Date] {
        
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var arrDates = [Date]()
        for day in 1...numDays {
            let dateString = "\(year) \(month) \(day)"
            if let date = formatter.date(from: dateString) {
                arrDates.append(date)
            }
        }
        
        return arrDates
    }
}
extension DateSlotCell: UICollectionViewDataSource,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  arrDatesInGivenMonthYear.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionCell", for: indexPath) as? DateCollectionCell else { return UICollectionViewCell() }
        let item = arrDatesInGivenMonthYear[indexPath.row]
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let showDate = formatter.string(from: item)
        let day = showDate.components(separatedBy: "-")
        cell.itemDate.text = day[2]
        formatter.dateFormat = "EEE"
        cell.itemDay.text = formatter.string(from: item)
        
        if(showDate == self.selectedDate){
            cell.itemDay.textColor = .white
            cell.itemDate.textColor = .white
            cell.baseView.layer.borderColor = Color.pink.color().cgColor
            cell.baseView.backgroundColor = Color.pink.color()
            

        }else {
            cell.itemDay.textColor = .black
            cell.itemDate.textColor = .black
            cell.baseView.layer.borderColor = UIColor.black.cgColor
            cell.baseView.backgroundColor = .clear
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height:85)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = arrDatesInGivenMonthYear[indexPath.row]
        let now = Date()
        let diff = Calendar.current.dateComponents([.year,.day,.month], from: now, to: item)
        if(diff.day! >= 0){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let showDate = formatter.string(from: item)
        self.selectedDate = showDate
        self.collectionView.reloadData()
        delegate?.selectedDate(selectedDate: showDate)
        }
    }
    
}

