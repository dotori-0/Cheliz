//
//  Notice.swift
//  Cheliz
//
//  Created by SC on 2022/09/14.
//

import Foundation

enum Notice {
    static let cancel = "취소"
    static let search = "검색"
    static let ok = "확인"
    static let deleteWarningTitle = "정말 삭제하시겠습니까?"
    static let deleteWarningMessage = "삭제된 항목은 복구가 불가합니다."
    static let deleteSucceeded = "성공적으로 삭제되었습니다."
    static let addSucceeded = "성공적으로 추가되었습니다."
    static let errorTitle = "오류 안내"
    static let tryAgain = "다시 시도해 주세요."
    static let errorInAddMessage = "추가에 오류가 발생했습니다. \(tryAgain)"     // addFailedMessage?
    static let errorInDeleteMessage = "삭제에 오류가 발생했습니다. \(tryAgain)"  // deleteFailedMessage?
//    static let errorInSearchMessage = "결과를 찾을 수 없습니다. \(tryAgain)"    // searchFailedMessage?
    static let errorInCheckMessage = "체크에 오류가 발생했습니다. \(tryAgain)"   // checkFailedMessge? // 👻 문구 다시 적기..
    static let sameMediaAlreadyExistsTitle = "중복 추가 불가 안내"
    static let sameMediaAlreadyExistsMessage = "이미 리스트에 추가되어 있는 미디어입니다. 다른 미디어를 선택해 주세요."
    
    static let backupFile = "백업 파일"
    static let backup = "백업하기"
    static let bring = "가져오기"
    static let backupInfo = "아래의 백업 파일들은 모두 Diary 앱 내부에 저장되어 있는 백업 파일들입니다.\nDiary 앱을 삭제하실 경우, 앱 내부에 저장된 백업 파일들도 함께 삭제됩니다.\n백업 후, 생성된 백업 파일을 안전한 곳으로 내보내 주세요."
    static let restoreInfo = "아이폰의 '파일 앱'으로부터 Diary 앱으로 가져온 백업 파일들은 아래에 함께 보이게 됩니다.\n원하시는 백업 파일을 선택하여 해당 백업본으로 앱을 복원할 수 있습니다."
    static let backupAndRestoreInfo = "⦁ 아래의 백업 파일들은 모두 Cheliz 앱 내부에 저장되어 있는 백업 파일들입니다.\nCheliz 앱을 삭제하실 경우, 앱 내부에 저장된 백업 파일들도 함께 삭제됩니다.\n백업 후, 생성된 백업 파일을 안전한 곳으로 내보내 주세요.\n⦁ 아이폰의 '파일 앱'으로부터 Cheliz 앱으로 가져온 백업 파일들은 아래에 함께 보이게 됩니다.\n원하시는 백업 파일을 선택하여 해당 백업본으로 앱을 복원할 수 있습니다."
}
