//
//  FileManager+Extension.swift
//  Cheliz
//
//  Created by SC on 2022/09/26.
//

import UIKit
import Zip

extension BaseViewController {
    func fetchDocumentDirectoryPath() -> URL? {
        guard let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            // 👻 alert
            return nil
        }
        
        return documentDirectoryPath
    }
    
    func createJSONBackupFile() {
        let repository = MediaRepository()
        
        // 👻 media.count 확인하고 alert
        guard let documentDirectoryPath = fetchDocumentDirectoryPath() else {
            return  // fetchDocumentDirectoryPath()에서 이미 alert 띄우고 있기 때문에 다시 알릴 필요 X
        }
        
        guard let encodedJSONString = repository.encode2() else {
            print("encodedJson is nil")
            return
        }
        
        let pathWithFileName = documentDirectoryPath.appendingPathComponent("backup.json")
        do {
            try encodedJSONString.write(to: pathWithFileName,
                                        atomically: true,
                                        encoding: .utf8)
        } catch {
            // 👻 alert
            print(error)
        }
        
        print("🤯🤯", encodedJSONString)
    }
    
    func saveBackupFile() {
        var urlPaths = [URL]()  // 백업할 파일의 배열
        
        guard let documentDirectoryPath = fetchDocumentDirectoryPath() else { return }
        
        let jsonFilePath = documentDirectoryPath.appendingPathComponent("backup.json")
        
        urlPaths.append(jsonFilePath)
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd_HH:mm:ss"  // ❔ 사용자가 해외로 이동할 경우를 고려하지 않아도 되는지?
        print(formatter.string(from: Date.now))
//            DateFormatterHelper.standard.set
        let fileName = formatter.string(from: Date.now)
        
        do {
            Zip.addCustomFileExtension("cheliz")
            let isValidExtension = Zip.isValidFileExtension("cheliz")
            print("isValidExtension: \(isValidExtension)")
            
            let backupFilePath = documentDirectoryPath.appendingPathComponent("\(fileName).cheliz")
            try Zip.zipFiles(paths: urlPaths, zipFilePath: backupFilePath, password: nil, progress: { progress in
                print(progress)  // 👻 progress view
            })
            
            print("Backup File Location: \(backupFilePath)")
            
            // 👻 alert - 완료 - 내보내 주세요 - 테이블뷰 리로드
            showActivityViewController(with: backupFilePath)
        } catch {
            // 👻 alert
            print(error)
        }
    }
    
    func showActivityViewController(with backupFileURL: URL) {
        let activityVC = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        present(activityVC, animated: true)
    }
    
    func fetchBackupFilesFromDocuments() -> [String]? {
        guard let documentDirectoryPath = fetchDocumentDirectoryPath() else {
            return nil  // fetchDocumentDirectoryPath()에서 이미 alert 띄우고 있기 때문에 다시 알릴 필요 X
        }
        
        do {
            let allFileURLs = try FileManager.default.contentsOfDirectory(at: documentDirectoryPath, includingPropertiesForKeys: nil)
            print("allFileURLs.count: \(allFileURLs.count)")
            
            let allBackupFileURLs = allFileURLs.filter { $0.pathExtension == "cheliz" }  // pathExtension: 확장자
            let allBackupFileNames = allBackupFileURLs.map { $0.lastPathComponent }
            print("allBackupFilesNames.count: \(allBackupFileNames.count)")
            
            return allBackupFileNames.sorted().reversed()
        } catch {
            alert(title: "백업 파일 찾기 오류",
                  message: "백업 파일 찾기에 실패했습니다.")
            print(error)
            return nil
        }
    }
}
