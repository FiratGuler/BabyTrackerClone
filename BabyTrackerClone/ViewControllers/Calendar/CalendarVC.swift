//
//  CalenderVC.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 1.11.2024.
//

import UIKit
import NeonSDK
import FirebaseFirestore

final class CalendarVC: UIViewController {
    
    private let customNavBar = CustomNavigationBar()
    private let dateLabel = UILabel()
    private var collectionView = NeonCollectionView<CalendarItem,CalendarCollectionCell>()
    private var tableView = CalendarTableView()
    private var calendarItemArray : [CalendarItem] = CalendarItem.CalenderData
    private var animation = LottieManager.createLottie(animation: .loadingCircle2)
    
    private var selectedIndexPath: IndexPath?
    private var firebaseData: [FirebaseDataType] = []
    private var firebaseDataModel: FirebaseDataModel? {
        didSet {
            fetchFirebaseData()
            animation.stop()
            animation.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupUI()
        didSelect()
        tableViewSwipeActions()
        FirebaseManager.shared.fetchAllData { [weak self] dataModel in
            self?.firebaseDataModel = dataModel
            
        }
    
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureDateLabel()
        configureCollectionView()
        configureCalendarTableView()
    }
    
    private func configureNavigationBar() {
        
        customNavBar.titleTextColor = .appPurple
        customNavBar.isRightButtonVisible = false
        customNavBar.setTitle("Calender")
        customNavBar.setLeftButtonIcon("AppBackIcon")
        
        view.addSubview(customNavBar)
        customNavBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        customNavBar.leftButton.addTarget(self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
    }
    
    private func configureDateLabel() {
        dateLabel.text = "Tue, Feb 12"
        dateLabel.font = UIFont(name: UIConstants.regularFont, size: 14)
        dateLabel.textAlignment = .center
        
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp.bottom).offset(22)
            make.left.right.equalToSuperview()
            make.height.equalTo(18)
        }
    }
    
    private func configureCalendarTableView() {
        
        tableView = CalendarTableView(
            objects: firebaseData,
            heightForRows: 70
        )

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(10)
            make.height.equalTo(200)
        }
        
        tableView.addSubview(animation)
        animation.snp.makeConstraints({make in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        })
    }
    
    private func configureCollectionView() {
        collectionView = NeonCollectionView<CalendarItem,CalendarCollectionCell>(
            objects: CalendarItem.CalenderData,
            leftPadding: 20,
            rightPadding: 20,
            horizontalItemSpacing: 20,
            widthForItem: 50
        )
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(22)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func didSelect() {
      
        collectionView.didSelect = { [weak self] object, indexPath in
            guard let self = self else { return }
            
            if let currentSelectedIndexPath = self.selectedIndexPath, currentSelectedIndexPath == indexPath {
                
                self.calendarItemArray[indexPath.row].didSelect = false
                self.calendarItemArray[0].didSelect = true
                self.selectedIndexPath = nil
            } else {
                
                for i in 0..<self.calendarItemArray.count {
                    self.calendarItemArray[i].didSelect = false
                }
                self.calendarItemArray[indexPath.row].didSelect = true
                self.selectedIndexPath = indexPath
            }
            
            let selectedCategory = self.calendarItemArray[indexPath.row].dataCategory
            if selectedCategory == .all {
                self.updateTableView()
            } else {
                self.filterTableView(by: selectedCategory)
            }
            
            
            self.collectionView.objects = self.calendarItemArray
        }
        
    }
    
    private func fetchFirebaseData() {
        firebaseData.removeAll()
        
        firebaseDataModel?.sleep.forEach { sleepData in
            firebaseData.append(.sleep(sleepData))
        }
        firebaseDataModel?.feeding.forEach { feedingData in
            firebaseData.append(.feeding(feedingData))
        }
        firebaseDataModel?.symptomps.forEach { symptomData in
            firebaseData.append(.symptom(symptomData))
        }
        
        tableView.objects = firebaseData

    }
    
    private func updateTableView() {
        guard let dataModel = firebaseDataModel else { return }
        
        var firebaseData: [FirebaseDataType] = []
        
        dataModel.sleep.forEach { sleepData in
            firebaseData.append(.sleep(sleepData))
        }
        dataModel.feeding.forEach { feedingData in
            firebaseData.append(.feeding(feedingData))
        }
        dataModel.symptomps.forEach { symptompsData in
            firebaseData.append(.symptom(symptompsData))
        }
        
        tableView.objects = firebaseData
        
    }
    
    private func filterTableView(by category: FirebaseDataCategory) {
        let filteredData: [FirebaseDataType]

        switch category {
        case .sleep:
            filteredData = firebaseData.filter {
                if case .sleep = $0 { return true }
                return false
            }
        case .feeding:
            filteredData = firebaseData.filter {
                if case .feeding = $0 { return true }
                return false
            }
        case .symptom:
            filteredData = firebaseData.filter {
                if case .symptom = $0 { return true }
                return false
            }
        case .all:
            filteredData = firebaseData
        }
        
        tableView.objects = filteredData
        tableView.reloadData()
    }
    
    private func deleteFromFirebaseData(indexPath: Int ) {
        DispatchQueue.main.async{
            self.firebaseData.remove(at: indexPath)
            self.tableView.objects = self.firebaseData
        }
    }
    
    private func tableViewSwipeActions() {
        tableView.trailingSwipeActions = [
            SwipeAction(title: "Delete", color: .red) { item, indexPath in
                switch item {
                case .feeding(let data):
                    FirebaseManager.shared.deleteFeedFromFireBase(id: data.id)
                    self.deleteFromFirebaseData(indexPath: indexPath.item)
                
                case .sleep(let data):
                    FirebaseManager.shared.deleteSleepFromFireBase(id: data.id)
                    self.deleteFromFirebaseData(indexPath: indexPath.item)
               
                case .symptom(let data):
                    FirebaseManager.shared.deleteSymptompsFromFireBase(id: data.id)
                    self.deleteFromFirebaseData(indexPath: indexPath.item)
                }
                
            }
        ]
    }
    
    
    // MARK: - Selector
    
    @objc private func leftBarButtonTapped() {
        self.dismiss(animated: true)
    }
}



