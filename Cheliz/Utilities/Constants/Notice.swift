//
//  Notice.swift
//  Cheliz
//
//  Created by SC on 2022/09/14.
//

import Foundation

enum Notice {
    static let home = "홈"
    static let search = "검색"
    static let searchMedia = "타이틀을 입력해 보세요"
    
    static let deleteWarningTitle = "정말 삭제하시겠습니까?"
    static let deleteWarningMessage = "삭제된 항목은 복구가 불가합니다."
    static let deleteSucceeded = "성공적으로 삭제되었습니다."
    
    static let addSucceeded = "성공적으로 추가되었습니다."
    
    static let watchCount = "본 횟수"
    static let record = "기록"
    static let notes = "메모"
    static let director = "Director"
    static let minute = "분"
    
    static let korean = "ko"
    static let english = "en"
    
    
    
    // MARK: - Error
    static let errorTitle = "오류 안내"
    static let tryAgain = "다시 시도해 주세요."
    static let noMediaReceivedMessage = "미디어 연결에 실패했습니다."
    static let errorInAddMessage = "추가에 오류가 발생했습니다.\n\(tryAgain)"     // addFailedMessage?
    static let errorInDeleteMessage = "삭제에 오류가 발생했습니다.\n\(tryAgain)"  // deleteFailedMessage?
//    static let errorInSearchMessage = "결과를 찾을 수 없습니다.\n\(tryAgain)"    // searchFailedMessage?
    static let errorInCheckMessage = "체크에 오류가 발생했습니다.\n\(tryAgain)"   // checkFailedMessge? // 👻 문구 다시 적기..
    static let errorInFileExtensionMessage = "백업 파일 타입에 오류가 발생했습니다.\n\(tryAgain)"
    
    static let sameMediaAlreadyExistsTitle = "미디어 중복 안내"
    static let sameMediaAlreadyExistsMessage = "이미 리스트에 추가되어 있는 미디어입니다.\n다른 미디어를 선택해 주세요."
    
    static let errorInWatchCountChangeMessage = "본 횟수 변경에 오류가 발생했습니다.\n\(tryAgain)"
    
    // MARK: - Backup & Restore
//    static let backupAndRestore = "백업 및 복원"
    static let backupFile = "백업 파일"
    static let backup = "백업하기"
    static let bring = "가져오기"
//    static let backupInfo = "아래의 백업 파일들은 모두 체리즈 앱 내부에 저장되어 있는 백업 파일들입니다.\n체리즈 앱을 삭제하실 경우, 앱 내부에 저장된 백업 파일들도 함께 삭제됩니다.\n백업 후, 생성된 백업 파일을 안전한 곳으로 내보내 주세요."
//    static let restoreInfo = "아이폰의 '파일 앱'으로부터 체리즈 앱으로 가져온 백업 파일들은 아래에 함께 보이게 됩니다.\n원하시는 백업 파일을 선택하여 해당 백업본으로 앱을 복원할 수 있습니다."
//    static let backupAndRestoreInfo = "⦁ 아래의 백업 파일들은 모두 체리즈 앱 내부에 저장되어 있는 백업 파일들입니다.\체리즈 앱을 삭제하실 경우, 앱 내부에 저장된 백업 파일들도 함께 삭제됩니다.\n백업 후, 생성된 백업 파일을 안전한 곳으로 내보내 주세요.\n⦁ 아이폰의 '파일 앱'으로부터 체리즈 앱으로 가져온 백업 파일들은 아래에 함께 보이게 됩니다.\n원하시는 백업 파일을 선택하여 해당 백업본으로 앱을 복원할 수 있습니다."
    static let backupAndRestoreInfo = "⦁ 아래의 백업 파일들은 모두 체리즈 앱 내부에 저장되어 있는 백업 파일들입니다.\n\n⦁ 체리즈 앱을 삭제하실 경우, 앱 내부에 저장된 백업 파일들도 함께 삭제됩니다. 백업 후, 생성된 백업 파일을 안전한 곳으로 내보내 주세요.\n\n⦁ 아이폰의 '파일 앱'으로부터 체리즈 앱으로 가져온 백업 파일들은 아래에 함께 보이게 됩니다. 원하시는 백업 파일을 선택하여 해당 백업본으로 앱을 복원하실 수 있습니다."
    static let deleteBackupWarningMessage = "삭제된 백업 파일은 복구가 불가합니다."
    static let importBackupFileSucceeded = "백업 파일을 성공적으로 불러왔습니다."
    
    static let restoreTitle = "복원 안내"
    static let restoreMessage = "선택하신 백업 파일로 복원하시겠습니까?"
    static let restoreSucceeded = "복원에 성공했습니다."
    static let cannotFindSelectedFile = "선택하신 파일을 찾을 수 없습니다."
    
    // MARK: - Record
    static let addRecord = "기록 추가하기"
    static let deleteRecordWarningMessage = "삭제된 기록은 복구가 불가합니다."
    
    static let addPeopleWatchedWith = "  같이 본 사람을 입력해 보세요"
    static let addNotes = "기록하고 싶은 내용을 입력해 보세요"
    
    // MARK: - Settings
    static let settings = "설정"
    static let fontSettings = "폰트 설정"
    static let updatePlanned = "업데이트 예정입니다."
    static let chelizUTType = "com.app.cheliz"
    
    enum NetworkError {
        static let networkError = "네트워크 연결 에러"
        static let networkErrorMessage = "네트워크 연결이 원활하지 않습니다.\n연결 상태를 확인하고 다시 시도해 주세요."
    }
    
    enum Action {
        static let ok = "확인"
        static let tryAgain = "재시도"
        static let next = "다음"
        static let cancel = "취소"
    }
}
