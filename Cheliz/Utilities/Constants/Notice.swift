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
    static let errorInSearchMessage = "결과를 찾을 수 없습니다. \(tryAgain)"    // searchFailedMessage?
    static let errorInCheckMessage = "체크에 오류가 발생했습니다. \(tryAgain)"   // checkFailedMessge? // 👻 문구 다시 적기..
}
