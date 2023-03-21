//
//  DetailViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/29.
//

import UIKit
import RealmSwift

final class DetailViewController: BaseViewController {
    // MARK: - Properties
    var isFromSearchView = false
    let detailView = DetailView()
//    let headerView = MediaInfoHeaderView()
    lazy var directorItemHeight = setDirectorItemHeight()
    lazy var castItemHeight = setCastItemHeight()
//    var directorItemHeight: CGFloat = 0
//    var castItemHeight: CGFloat = 0
//    lazy var headerView = MediaInfoHeaderView(directorItemHeight: directorItemHeight, castItemHeight: castItemHeight)
    var headerView = MediaInfoHeaderView()
    var itemHeight: CGFloat = 0
    
    private let repository = MediaRepository()
//    private var records = List<Record>() {
    private var records: Results<Record>! {
        didSet {
            print("Records changed")
//            detailView.tableView.reloadSections(IndexSet(integer: RecordSection.record.rawValue), with: .fade)
        }
    }
    
    var fetched = 0
    
    var media: Media?
    var directors: [Credit] = []
    var cast: [Credit] = []
    
    var notes: String?

    
    // MARK: - Life Cycle
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isFromSearchView { tabBarController?.tabBar.isHidden = true }
        
        fetchCredits()
        
//        directorItemHeight = setDirectorItemHeight()
//        castItemHeight = setCastItemHeight()
        
//        setHeaderView()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        headerView.infoContainerView.setGradient()  // 다크모드/라이트 모드와는 상관이 없고 스와이프하다가 스와이프 취소하면 나타남
        if isFromSearchView { return }
        fetchRecords()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        print("🐝", #function)
        
//        editNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        headerView.infoContainerView.setGradient()  // 뷰에 들어갔을 때 바로 나오지만 시간차가 조금 있음
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        detailView.tableView.updateHeaderViewHeight()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        headerView.infoContainerView.setGradient()  // 다크모드/라이트모드 전환시에만 됨
//        detailView.tableView.updateHeaderViewHeight()
    }
    
    // MARK: - Setting Methods
    private func setTableView() {
        detailView.tableView.dataSource = self
        detailView.tableView.delegate = self
        detailView.tableView.allowsSelection = false
    }
    
    private func setHeaderView() {
//        headerView = MediaInfoHeaderView(directorItemHeight: directorItemHeight, castItemHeight: castItemHeight)
        
        headerView.directorsExist = !directors.isEmpty
        headerView.castExists = !cast.isEmpty
        headerView.setConstraintsOfCollectionViews()
    }
    
    // MARK: - Design Methods
    override func setUI() {
        super.setUI()
    }
    
    // MARK: - Realm Methods
//    private func fetchRecords(reloadSection: Bool = true, row: Int = 0, withAnimation: Bool = true) {
    private func fetchRecords(reload: Bool = true, reloadSection: Bool = true, row: Int = 0, withAnimation: Bool = true) {
        print("🆕🍒 fetched \(fetched)")
        fetched += 1
//        records = repository.fetchRecords()  // ❔repository 없이 media.records로 해도 되긴 하는데 이렇게 분리하는 것이 더 나은지?
        guard let media = media else {
            print("No media received")
            alert(message: Notice.noMediaReceivedMessage)
            return
        }
        
        records = repository.fetchRecords(of: media)
        
        if reload {
            reloadSection ? detailView.tableView.reloadSections(IndexSet(integer: RecordSection.record.rawValue), with: withAnimation ? .fade : .none) :
            detailView.tableView.reloadRows(at: [IndexPath(row: row, section: RecordSection.record.rawValue)], with: withAnimation ? .fade : .none)
        } else {
            detailView.tableView.deleteRows(at: [IndexPath(row: row, section: RecordSection.record.rawValue)], with: withAnimation ? .fade : .none)
        }
        
//        detailView.tableView.relo
    }
    
    private func editNotes() {
        guard let media = media else {
            print("No media received")
            alert(message: Notice.noMediaReceivedMessage)
            return
        }
        
        repository.editNotes(of: media, to: notes)
    }
    
    // MARK: - Networking Methods
    private func fetchCredits() {
        guard let media = media else {
            print("No media received")
            alert(message: Notice.noMediaReceivedMessage)
            return
        }
        
        let mediaType = MediaType(rawValue: media.mediaType) ?? .movie
        let mediaID = media.TMDBid
        
        // viewForHeader에서 옮겨옴
        headerView.showMediaInfo(media: media)
        
        DispatchQueue.global().async {
            TMDBAPIManager.shared.fetchCredits(mediaType: mediaType, mediaID: mediaID) { [weak self] data in
                let credits = ParsingManager.parseCredits(data)
                self?.directors = credits[0]
                self?.cast = credits[1]
                
                self?.detailView.tableView.reloadData()
                self?.headerView.directorCollectionView.reloadData()
                self?.headerView.castCollectionView.reloadData()
                
                self?.setHeaderView()
                if let directorsHeight = self?.setDirectorItemHeight() {
                    self?.directorItemHeight = directorsHeight
                }
    //            self?.directorItemHeight = self?.setDirectorItemHeight() ?? 0
                if let castHeight = self?.setCastItemHeight() {
                    self?.castItemHeight = castHeight
                }
    //            self?.castItemHeight = self?.castHeight()
    //            self?.setTableView()
    //            self?.detailView.tableView.updateHeaderViewHeight()
    //            self?.detailView.tableView.updateHeaderViewHeight2(overviewHeight: self?.heightForOverview() ?? 0,
    //                                                               directorHeight: self?.directorItemHeight ?? 0,
    //                                                               castHeight: self?.castItemHeight ?? 0)
//                self?.detailView.tableView.reloadData()
//                self?.detailView.tableView.layoutSubviews()
//                self?.headerView.directorCollectionView.reloadData()
//                self?.headerView.castCollectionView.reloadData()
            }
        }
        
        // DispatchGroup
//        let group = DispatchGroup()
//        var credits = Data()
//
//        group.enter()
////        DispatchQueue.global().async {
//            TMDBAPIManager.shared.fetchCredits(mediaType: mediaType, mediaID: mediaID) { [weak self] data in
//                group.leave()
//                credits = data
//            }
//
//        group.notify(queue: .main) {
//            let credits = ParsingManager.parseCredits(credits)
//            self.directors = credits[0]
//            self.cast = credits[1]
//            self.setHeaderView()
////            if let directorsHeight = self.setDirectorItemHeight() {
//            self.directorItemHeight = self.setDirectorItemHeight()
//
//            self.castItemHeight = self.setCastItemHeight()
//            self.detailView.tableView.reloadData()
//
//            self.headerView.directorCollectionView.reloadData()
//            self.headerView.castCollectionView.reloadData()
        }
//        }
//        TMDBAPIManager.shared.fetchCredits(mediaType: MediaType(rawValue: media.mediaType) ?? .movie, mediaID: media.TMDBid) { [weak self] data in
//            let credits = ParsingManager.parseCredits(data)
//            self?.directors = credits[0]
//            self?.cast = credits[1]
//            self?.setHeaderView()
//            if let directorsHeight = self?.setDirectorItemHeight() {
//                self?.directorItemHeight = directorsHeight
//            }
////            self?.directorItemHeight = self?.setDirectorItemHeight() ?? 0
//            if let castHeight = self?.setCastItemHeight() {
//                self?.castItemHeight = castHeight
//            }
////            self?.castItemHeight = self?.castHeight()
////            self?.setTableView()
////            self?.detailView.tableView.updateHeaderViewHeight()
////            self?.detailView.tableView.updateHeaderViewHeight2(overviewHeight: self?.heightForOverview() ?? 0,
////                                                               directorHeight: self?.directorItemHeight ?? 0,
////                                                               castHeight: self?.castItemHeight ?? 0)
//            self?.detailView.tableView.reloadData()
//
//            self?.headerView.directorCollectionView.reloadData()
//            self?.headerView.castCollectionView.reloadData()
//        }
    
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFromSearchView { return 1 }
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 { return nil }
        
//        guard let media = media else {
//            print("No media received")
//            alert(message: Notice.noMediaReceivedMessage)
//            return UIView()
//        }

////        let headerView = MediaInfoHeaderView()
////        headerView.infoContainerView.setGradient()  // X
//        headerView.showMediaInfo(media: media)
        
        headerView.directorCollectionView.dataSource = self
        headerView.directorCollectionView.delegate = self
        headerView.castCollectionView.dataSource = self
        headerView.castCollectionView.delegate = self
        
        // 동작 X
//        DispatchQueue.main.async {
//            self.headerView.directorCollectionView.snp.makeConstraints { make in
//                make.height.equalTo(self.directorItemHeight)
//            }
//
//            self.headerView.castCollectionView.snp.makeConstraints { make in
//                make.height.equalTo(self.castItemHeight)
//            }
//        }
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 { return 40 }
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
//        let backdropHeight = headerView.backdropImageView.frame.height
        let backdropHeight = screenHeight * 0.25
        let overlapHeight = 30.0
        let posterHeight = screenWidth * 0.3 * 1.5
        let overviewHeight = heightForOverview()
        let space = 24.0
        
        let headerViewHeight = backdropHeight - overlapHeight + posterHeight + overviewHeight + directorItemHeight + castItemHeight + space * 4  // 아래에 여백을 더하기 위해 space 1 번 더 추가
//        print("backdropHeight: \(backdropHeight)")
//        print("directorItemHeight: \(directorItemHeight)")
//        print("overviewHeight: \(overviewHeight)")
//        print("castItemHeight: \(castItemHeight)")
//        print("headerViewHeight: \(headerViewHeight)")
        
        return headerViewHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = RecordSection(rawValue: section)
        switch section {
            case .watchCount:
                return Notice.watchCount
            case .record:
                return Notice.record
            case .notes:
                return Notice.notes
            case .none:
                print("titleForHeaderInSection None")
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = RecordSection(rawValue: section)
        switch section {
            case .watchCount:
                return 1
            case .record:
                return records.count + 1
            case .notes:
                return 1
            case .none:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = RecordSection(rawValue: indexPath.section)
        switch section {
            case .watchCount:
                return 56
            case .record:
                if indexPath.row != records.count {
                    return 102
                } else {
                    return 56
                }
            case .notes:
                return UIScreen.main.bounds.height / 4
            case .none:
                return 0
        }
//        return indexPath.section == 1 ? 56 : (indexPath.row ==  102)
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let media = media else {
            print("No media received")
            alert(message: Notice.noMediaReceivedMessage)
            return UITableViewCell()
        }
        
        let section = RecordSection(rawValue: indexPath.section)
        switch section {
            case .watchCount:
                guard let watchCountCell = tableView.dequeueReusableCell(withIdentifier: WatchCountTableViewCell.reuseIdentifier,
                                                                         for: indexPath) as? WatchCountTableViewCell else {
                    print("Cannot find WatchCountTableViewCell")
                    return UITableViewCell()
                }
                
                watchCountCell.setCountLabel(as: media.watchCount)
                watchCountCell.stepper.media = media
                watchCountCell.stepper.value = Double(media.watchCount)
//                watchCountCell.stepper.value = Double(100000000000000000000000000000)
                watchCountCell.stepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
                
                return watchCountCell
            case .record:
                if indexPath.row != records.count {
                    guard let recordCell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.reuseIdentifier,
                                                                         for: indexPath) as? RecordTableViewCell else {
                        print("Cannot find RecordTableViewCell")
                        return UITableViewCell()
                    }
                    // Date Picker
//                    recordCell.datePicker.media = media
//                    recordCell.datePicker.record = media.records[indexPath.row]
                    recordCell.tag = indexPath.row  // ?
//                    recordCell.datePicker.date = media.records[indexPath.row].watchedDate
                    recordCell.datePicker.tag = indexPath.row
//                    recordCell.datePicker.date = media.records[indexPath.row].watchedDate
                    recordCell.datePicker.date = media.records[recordCell.datePicker.tag].watchedDate  // 이것도 이렇게 태그값을 쓰는 것이 나은지?
//                    print("📆 \(recordCell.datePicker.date)")
                    recordCell.datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)

                    
                    // Tags Field
                    recordCell.tagsField.tag = indexPath.row
                    
                    if recordCell.tagsField.tag == records.count - 1 { recordCell.tagsField.becomeFirstResponder() }
                    
//                    print("🆕")
                    let record = records[recordCell.tagsField.tag]
//                    print("🏷 \(recordCell.tagsField.tag)")
                    
//                    print("🐥 recordCell.tag: \(recordCell.tag)")
//                    print("🐥 tagsField.tag: \(recordCell.tagsField.tag)")
//                    print("🐥 record id: \(record.id)")  // 여기서는 row가 0일 때 0번째 record를 잘 가리킴.
                    
//                    let people = record.watchedWith
                    let people = records[recordCell.tag].watchedWith
//                    let peopleNames = people.map { $0.name }
                    var peopleNames: [String] = []
                    people.forEach { person in
                        peopleNames.append(person.name)
                    }
//                    print("people: \(people.map { $0.name })")
//                    print("people: \(peopleNames)")  // 🟩
                    
                    recordCell.addTags(of: people)  // 🟩

                    
                    recordCell.tagsField.onDidAddTag = { field, tag in
                        print("🐢 recordCell.tag: \(recordCell.tag)")
                        print("🐢 tagsField.tag: \(recordCell.tagsField.tag)")
                        print("🐢 record id: \(record.id)")  // row가 0인데도 record는 1을 가리키고 있었음,, record를 따로 상수로 빼 놓으면 안 될 듯
                        print("🐢 record id by cell tag: \(self.records[recordCell.tagsField.tag].id)")
                        
//                        print("✏️ DidAddTag", tag.text, "➡️ \(record.id)")
                        print("✏️ DidAddTag", tag.text, "➡️ \(self.records[recordCell.tag].id)")
//                        self.add(personNamed: tag.text, to: self.records[recordCell.tagsField.tag])
//                        self.add(personNamed: tag.text, to: record)  // 🟩
                        self.add(personNamed: tag.text, to: self.records[recordCell.tag])
//                        print("🐵 추가했음", tag.text, "➡️ \(record.id)")
                        print("🐵 추가했음", tag.text, "➡️ \(self.records[recordCell.tag].id)")
                    }
                    
                    recordCell.tagsField.onDidRemoveTag = { field, tag in
                        print("✏️ DidRemoveTag", tag.text)
//                        self.delete(personNamed: tag.text, from: record)
                        self.delete(personNamed: tag.text, from: self.records[recordCell.tag])
                    }
                                        
//                    print("💎 after added")
//                    print("record id: \(record.id)")
//                    let addedPeople = record.watchedWith
                    let addedPeople = records[recordCell.tag].watchedWith
//                    let addedPeopleNames = addedPeople.map { $0.name }
                    var addedPeopleNames: [String] = []
                    addedPeople.forEach { person in
                        addedPeopleNames.append(person.name)
                    }
//                    print("people: \(people.map { $0.name })")
//                    print("people: \(addedPeopleNames)")  // 🟩
                    
//                    recordCell.addTags(of: people)
//                    print("people: \(people.map { $0.name })")
                    
                    return recordCell
                } else {
                    guard let addRecordCell = tableView.dequeueReusableCell(withIdentifier: AddRecordTableViewCell.reuseIdentifier,
                                                                            for: indexPath) as? AddRecordTableViewCell else {
                        print("Cannot find AddRecordTableViewCell")
                        return UITableViewCell()
                    }
                    addRecordCell.addButton.media = media
                    addRecordCell.addButton.addTarget(self, action: #selector(addRecordButtonClicked), for: .touchUpInside)
                    
                    return addRecordCell
                }
                
//                return indexPath.row == records.count ? addRecordCell : recordCell
            case .notes:
                guard let notesCell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.reuseIdentifier,
                                                                    for: indexPath) as? NotesTableViewCell else {
                    print("Cannot find NotesTableViewCell")
                    return UITableViewCell()
                }
                notesCell.notesTextView.delegate = self
                
//                if media.notes != nil {
//                    notesCell.notesTextView.textColor = .label
//                    notesCell.notesTextView.text = media.notes
//                }
                
                if let notes = media.notes {
                    print("📗", notes)
                    notesCell.notesTextView.textColor = .label
                    notesCell.notesTextView.text = notes
                }
                
                return notesCell
            case .none:
                print("cellForRowAt None")
        }
        
        return UITableViewCell()
    }
    
    // MARK: - Action Methods
    @objc private func stepperChanged(sender: MediaPassableStepper) {
        guard let media = sender.media else {
            print("Cannot find media in MediaPassableStepper")  // 👻 alert
            return
        }
        
        repository.changeWatchCount(of: media, to: Int(sender.value)) {
            self.alert(title: Notice.errorTitle, message: Notice.errorInWatchCountChangeMessage)
        }
        
        detailView.tableView.reloadSections(IndexSet(integer: RecordSection.watchCount.rawValue), with: .fade)  // 👻 애니메이션 없는 게 더 나은지?
    }
    
//    @objc private func dateChanged(sender: MediaAndRecordPassableDatePicker)  {
    @objc private func dateChanged(sender: UIDatePicker)  {
//        guard let media = sender.media, let record = sender.record else {
//            print("Cannot find media or record in MediaAndRecordPassableDatePicker")  // 👻 alert
//            return
//        }
        
//        guard let media = sender.media else {
//            print("Cannot find media or record in MediaAndRecordPassableDatePicker")  // 👻 alert
//            return
//        }
        let record = records[sender.tag]
        
        print("🆔", record.id)
        repository.changeDate(of: record, to: sender.date)
        fetchRecords(reloadSection: false, row: sender.tag)
    }
    
    @objc private func addRecordButtonClicked(sender: MediaPassableButton) {
        guard let media = sender.media else {
            print("Cannot find media in MediaPassableStepper")  // 👻 alert
            return
        }
        
        let record = Record(mediaID: media.id, TMDBid: media.TMDBid, title: media.title, watchedDate: Date.now)
        repository.addRecord(of: record, to: media)
        
//        fetchRecords()
        detailView.tableView.insertRows(at: [IndexPath(row: records.count - 1, section: RecordSection.record.rawValue)], with: .fade)
//        fetchRecords(reloadSection: false, row: records.count - 1, withAnimation: true)
    }
    
    private func add(personNamed name: String, to record: Record) {
        var person: Person?
        
//        if repository.samePersonExists(named: name) {
//            if repository.samePersonExistsInRecord(named: name, in: record) { return }
//            person = repository.fetchPerson(named: name)
//        } else {
//            person = Person(name: name)
//        }
        
        if repository.samePersonExistsInRecord(named: name, in: record) {
            return
        } else if repository.samePersonExists(named: name) {
            person = repository.fetchPerson(named: name)
        } else {
            person = Person(name: name)
        }
        
        guard let person = person else {
            print("No person")
            return
        }

        repository.add(person: person, to: record)
        
        // ❔ 어느 것이 더 좋은 코드인지..?
//        if repository.samePersonExists(named: name) {
//            let person = repository.fetchPerson(named: name)
//            repository.add(person: person, to: record)
//        } else {
//            let person = Person(name: name)
//            repository.add(person: person, to: record)
//        }
    }
    
    private func delete(personNamed name: String, from record: Record) {
        let person = repository.fetchPerson(named: name)
        repository.delete(person: person, from: record)
    }
}

// MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section != RecordSection.record.rawValue { return nil }
        print("🗑 \(records[indexPath.row].id)")
        let delete = UIContextualAction(style: .normal, title: nil) { action, view, completion in
            self.alert(title: Notice.deleteWarningTitle,
                       message: Notice.deleteRecordWarningMessage,
                       allowsCancel: true) { _ in
                self.repository.deleteRecord(of: self.records[indexPath.row]) {
                    self.detailView.makeToast(Notice.deleteSucceeded,
                                              duration: 1,
                                              position: .center, style: self.toastStyle)
//                    self.fetchRecords(withAnimation: false)
                    self.fetchRecords(reload: false, row: indexPath.row, withAnimation: true)
                } errorHandler: {
                    self.alert(title: Notice.errorTitle,
                               message: Notice.errorInDeleteMessage)
                }

            }
        }
        
        delete.image = UIImage(systemName: SFSymbol.trash)
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == headerView.directorCollectionView ? directors.count : cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print("🐳")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreditsCollectionViewCell.reuseIdentifier, for: indexPath) as? CreditsCollectionViewCell else {
            print("Cannot find CreditsCollectionViewCell")
            return UICollectionViewCell()
        }
        
        if collectionView == headerView.directorCollectionView {
            cell.showCreditInfo(of: directors[indexPath.item])
            itemHeight = itemHeight(collectionView: headerView.directorCollectionView)
        } else {
            cell.showCreditInfo(of: cast[indexPath.item])
            itemHeight = itemHeight(collectionView: headerView.castCollectionView)
        }
        
        if collectionView == headerView.directorCollectionView {
//            print("🐻‍❄️🐻‍❄️")
        } else if collectionView == headerView.castCollectionView {
//            print("🐹🐹")
        } else  {
//            print("🐰🐰")
        }
        
        DispatchQueue.main.async {
//            cell.profileView.profileImageView.layoutIfNeeded()  // 스크롤을 빨리 하면 이미지 모서리가 깎이지 않는 이슈 해결 코드
//            cell.profileView.profileImageView.layer.cornerRadius = cell.profileView.profileImageView.frame.width / 2
            
            cell.profileView.layoutIfNeeded()  // 스크롤을 빨리 하면 이미지 모서리가 깎이지 않는 이슈 해결 코드
            cell.profileView.layer.cornerRadius = cell.profileView.frame.width / 2
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // item 개수가 0이 아니어야만 호출이 되는듯?
//        print("🌊")

        // 🐋 -> 🌊 -> 🐳
        // setCollectionViewLayout() -> sizeForItemAt -> cellForItemAt

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreditsCollectionViewCell.reuseIdentifier, for: indexPath) as? CreditsCollectionViewCell else {
            print("Cannot find CreditsCollectionViewCell")
            return .zero
        }

        // ❔map은 $0가 없다면 아예 뛰어 넘는 구조인지?
        let directorNames = directors.map { $0.name }
        let longestDirectorName = directorNames.reduce("") { $0.count > $1.count ? $0 : $1 }
//        print("🐠", longestDirectorName)
        let directorJob = Notice.director

        let castNames = cast.map { $0.name }
        let longestCastName = castNames.reduce("") { $0.count > $1.count ? $0 : $1 }

        let characterNames = cast.map { $0.character }
        let longestCharacterName = characterNames.reduce("") { $0.count > $1.count ? $0 : $1 }
//        print("🦭", longestCharacterName)

        // 방법 1
        if collectionView == headerView.directorCollectionView {
            cell.nameLabel.text = longestDirectorName
            cell.characterLabel.text = directorJob
        } else {
            cell.nameLabel.text = longestCastName
            cell.characterLabel.text = longestCharacterName
        }

        cell.nameLabel.sizeToFit()
        cell.characterLabel.sizeToFit()

        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth / 5
        let profileImageViewHeight = itemWidth * 0.9

        // 셀 너비를 지정하고
        cell.contentView.snp.makeConstraints { make in
            make.width.equalTo(itemWidth)
        }

        // 셀 내부 객체들 레이아웃 다시 잡아도
        cell.setConstraints()

        let itemHeight = profileImageViewHeight
                        + cell.spacingBetweenProfileImageAndName
                        + cell.nameLabel.frame.height
                        + cell.spacingBetweenNameAndCharacter
                        + cell.characterLabel.frame.height


//        print("🍒", profileImageViewHeight)
//        print("🍒", cell.spacingBetweenProfileImageAndName)
//        print("🍒", cell.nameLabel.frame.height)  // 16.5  // 레이블 텍스트가 1 줄일 때의 높이만 계산됨
//        print("🍒", cell.spacingBetweenNameAndCharacter)
//        print("🍒", cell.characterLabel.frame.height)  // 16.0 항상 같은 숫자만 찍힘

//        return CGSize(width: itemWidth, height: itemHeight)


        // 방법 4
        // 방법 1과 마찬가지로 레이블 텍스트가 1 줄일 때의 높이만 계산됨
        cell.contentView.snp.makeConstraints { make in
            make.width.equalTo(itemWidth)
        }
        let cellSize = cell.itemSizeFittedWithContents(name: collectionView == headerView.directorCollectionView ? longestDirectorName : longestCastName,
                                                       character: collectionView == headerView.directorCollectionView ? directorJob : longestCharacterName)
//        return cellSize

        // 방법 5
//        let itemSize

        // 방법 6 - O
        func heightForLabel(text: String, textSize: CGFloat) -> CGFloat {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: itemWidth, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = UIFont.meringue(size: textSize)
            label.text = text
            label.sizeToFit()

            return label.frame.height
        }

        // 위 1, 4, 5 방법과 아래 커멘트는, (가장 긴 이름 + 가장 긴 배역)의 높이로 계산하는 문제 있음
        // (이름 + 배역) 높이 중 가장 큰 값으로 지정해야 함
//        let nameLabelHeight = heightForLabel(text: collectionView == headerView.directorCollectionView ? longestDirectorName : longestCastName,
//                                             textSize: 14)
//        let characterLabelHeight = heightForLabel(text: collectionView == headerView.directorCollectionView ? directorJob : longestCharacterName,
//                                                  textSize: 13.5)
        let directorJobs = directors.map { $0.character }
        let directorNameHeights = directorNames.map { heightForLabel(text: $0, textSize: 14) }
        let directorJobHeights = directorJobs.map { heightForLabel(text: $0, textSize: 13.5) }
        let directorLabelsHeights = zip(directorNameHeights, directorJobHeights).map(+)
        let maxDirectorLabelsHeight = directorLabelsHeights.reduce(0) { $0 > $1 ? $0 : $1 }
//        directorLabelsHeight.reduce(0) { partialResult, <#CGFloat#> in
//            <#code#>
//        }
//
//        directorLabelsHeight.reduce(into: <#T##Result#>) { partialResult, <#CGFloat#> in
//            <#code#>
//        }

        let castNameHeights = castNames.map { heightForLabel(text: $0, textSize: 14) }
        let characterNameHeights = characterNames.map { heightForLabel(text: $0, textSize: 13.5) }
        let castLabelsHeights = zip(castNameHeights, characterNameHeights).map(+)
        let maxCastLabelsHeight = castLabelsHeights.reduce(0) { $0 > $1 ? $0 : $1 }

        let itemHeight2 = profileImageViewHeight
                        + cell.spacingBetweenProfileImageAndName
//                        + nameLabelHeight
                        + cell.spacingBetweenNameAndCharacter
//                        + characterLabelHeight
                        + (collectionView == headerView.directorCollectionView ? maxDirectorLabelsHeight : maxCastLabelsHeight)
//                        + maxDirectorLabelsHeight

        let directorsHeight = profileImageViewHeight
                            + cell.spacingBetweenProfileImageAndName
                            + cell.spacingBetweenNameAndCharacter
                            + maxDirectorLabelsHeight

        let castHeight = profileImageViewHeight
                        + cell.spacingBetweenProfileImageAndName
                        + cell.spacingBetweenNameAndCharacter
                        + maxCastLabelsHeight

        if collectionView == headerView.directorCollectionView {
//            print("🐻‍❄️", itemHeight2)  // ❔ 절대 안 찍힘 -> 찍힘 . . .
//            print("🐻‍❄️ directorsHeight:", directorsHeight)
//            print("🐻‍❄️ castHeight:", castHeight)
        } else if collectionView == headerView.castCollectionView {
//            print("🐹", itemHeight2)
        } else  {
            print("🐰", itemHeight2)
        }

        DispatchQueue.main.async {
            cell.profileView.profileImageView.layoutIfNeeded()  // 스크롤을 빨리 하면 이미지 모서리가 깎이지 않는 이슈 해결 코드
            cell.profileView.profileImageView.layer.cornerRadius = cell.profileView.profileImageView.frame.width / 2
        }
        
        headerView.updateConstraintsOfCollectionViews(directorsHeight: directorsHeight, castHeight: castHeight)
        
        return CGSize(width: itemWidth, height: itemHeight2)
    }



}

// MARK: - Height Methods
extension DetailViewController {
    private func itemHeight(collectionView: UICollectionView) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth / 5
        let profileImageViewHeight = itemWidth * 0.9
        
        let directorNames = directors.map { $0.name }
        let directorJobs = directors.map { $0.character }
        let castNames = cast.map { $0.name }
        let characterNames = cast.map { $0.character }
 
        let directorNameHeights = directorNames.map { heightForLabel(text: $0, textSize: 14) }
        let directorJobHeights = directorJobs.map { heightForLabel(text: $0, textSize: 13.5) }
        let directorLabelsHeights = zip(directorNameHeights, directorJobHeights).map(+)
        let maxDirectorLabelsHeight = directorLabelsHeights.reduce(0) { $0 > $1 ? $0 : $1 }

        let castNameHeights = castNames.map { heightForLabel(text: $0, textSize: 14) }
        let characterNameHeights = characterNames.map { heightForLabel(text: $0, textSize: 13.5) }
        let castLabelsHeights = zip(castNameHeights, characterNameHeights).map(+)
        let maxCastLabelsHeight = castLabelsHeights.reduce(0) { $0 > $1 ? $0 : $1 }
        
        let itemHeight = profileImageViewHeight
                        + CreditsCollectionViewCell().spacingBetweenProfileImageAndName
                        + CreditsCollectionViewCell().spacingBetweenNameAndCharacter
                        + (collectionView == headerView.directorCollectionView ? maxDirectorLabelsHeight : maxCastLabelsHeight)
        
        return itemHeight
    }
    
    private func setDirectorItemHeight() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth / 5
        let profileImageViewHeight = itemWidth * 0.9
        
        let directorNames = directors.map { $0.name }
        let directorJobs = directors.map { $0.character }
//        let castNames = cast.map { $0.name }
//        let characterNames = cast.map { $0.character }
 
        let directorNameHeights = directorNames.map { heightForLabel(text: $0, textSize: 14) }
        let directorJobHeights = directorJobs.map { heightForLabel(text: $0, textSize: 13.5) }
        let directorLabelsHeights = zip(directorNameHeights, directorJobHeights).map(+)
        let maxDirectorLabelsHeight = directorLabelsHeights.reduce(0) { $0 > $1 ? $0 : $1 }

//        let castNameHeights = castNames.map { heightForLabel(text: $0, textSize: 14) }
//        let characterNameHeights = characterNames.map { heightForLabel(text: $0, textSize: 13.5) }
//        let castLabelsHeights = zip(castNameHeights, characterNameHeights).map(+)
//        let maxCastLabelsHeight = castLabelsHeights.reduce(0) { $0 > $1 ? $0 : $1 }
        
        let itemHeight = profileImageViewHeight
                        + CreditsCollectionViewCell().spacingBetweenProfileImageAndName
                        + CreditsCollectionViewCell().spacingBetweenNameAndCharacter
                        + maxDirectorLabelsHeight
        
        return itemHeight
    }
    
    private func setCastItemHeight() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth / 5
        let profileImageViewHeight = itemWidth * 0.9

        let castNames = cast.map { $0.name }
        let characterNames = cast.map { $0.character }

        let castNameHeights = castNames.map { heightForLabel(text: $0, textSize: 14) }
        let characterNameHeights = characterNames.map { heightForLabel(text: $0, textSize: 13.5) }
        let castLabelsHeights = zip(castNameHeights, characterNameHeights).map(+)
        let maxCastLabelsHeight = castLabelsHeights.reduce(0) { $0 > $1 ? $0 : $1 }
        
        let itemHeight = profileImageViewHeight
                        + CreditsCollectionViewCell().spacingBetweenProfileImageAndName
                        + CreditsCollectionViewCell().spacingBetweenNameAndCharacter
                        + maxCastLabelsHeight
        
        return itemHeight
    }
    
    private func heightForLabel(text: String, textSize: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth / 5

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: itemWidth, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.meringue(size: textSize)
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
    
    private func heightForOverview() -> CGFloat {
        guard let media = media else {
            print("No media received")
            alert(message: Notice.noMediaReceivedMessage)
            return 60
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let labelWidth = screenWidth - (32 + 24)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: labelWidth, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.meringue(size: 14)
        label.text = media.overview
        label.sizeToFit()
        
        return label.frame.height
    }
}

// MARK: - UITableView Extension
extension UITableView {
    func updateHeaderViewHeight() {
        if let header = self.tableHeaderView {
            let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            header.frame.size.height = newSize.height
        }
    }
    
    func updateHeaderViewHeight2(overviewHeight: CGFloat, directorHeight: CGFloat, castHeight: CGFloat) {
        if let header = self.tableHeaderView {
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            
    //        let backdropHeight = headerView.backdropImageView.frame.height
            let backdropHeight = screenHeight * 0.25
            let overlapHeight = 30.0
            let posterHeight = screenWidth * 0.3 * 1.5
            let overviewHeight = overviewHeight
            let space = 24.0
            
            let headerViewHeight = backdropHeight + overlapHeight + posterHeight + overviewHeight + directorHeight + castHeight + space * 4
            
            print("✌🏻")
            print("backdropHeight: \(backdropHeight)")
            print("directorItemHeight: \(directorHeight)")
            print("overviewHeight: \(overviewHeight)")
            print("castItemHeight: \(castHeight)")
            print("headerViewHeight: \(headerViewHeight)")
            
//            let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            header.frame.size.height = headerViewHeight
        }
    }
}

// MARK: - UITextViewDelegate
extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .secondaryLabel {
            textView.text = nil
            textView.textColor = .label
        }
        
//        notes = textView.text
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("📗", textView.text)
        notes = textView.text.isEmpty ? nil : textView.text
        print("📒", notes)
        
        editNotes()
        
        if textView.text.isEmpty {
            textView.text = Notice.addNotes
            textView.textColor = .secondaryLabel
        }
    }
}
