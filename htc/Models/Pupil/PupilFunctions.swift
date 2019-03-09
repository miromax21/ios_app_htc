//
//  PupilFunctions.swift
//  htc
//
//  Created by Princess Max on 07.02.2019.
//  Copyright © 2019 Princess Max. All rights reserved.
//

import Foundation
class PupilFunctions {
    static let PUPILS_SAVE_FILE_NAME = "pupils.json"
    static func createPupils(pupil:PupilModel){
        PupilData.pupilModels.append(pupil)
        self.savePupilsToLocalFile()
    }
    static func readTrips(completion: @escaping () -> ()){
        DispatchQueue.global(qos: .background).sync {
            if PupilData.pupilModels.count == 0{
                PupilData.pupilModels = self.getPupilsFromLocalFile()
            }
        }
        DispatchQueue.main.async {
            completion()
        }
    }

    static func redPupil(by id:UUID, completion: @escaping (PupilModel?) ->()){
        DispatchQueue.global(qos: .userInitiated).async {
            let pupil = PupilData.pupilModels.first(where: {$0.id == id})
            DispatchQueue.main.async {
                completion(pupil)
            }
        }
    }
    static func deleteTrip(index:Int){
        PupilData.pupilModels.remove(at: index)
        self.savePupilsToLocalFile()
    }
    
    static func updatePupil(index:Int, name: String, last_name:String?,grade_point_average:Int?){
        PupilData.pupilModels[index] = PupilModel(name: name, last_name: last_name, grade_point_average: grade_point_average)
        let pathDirectory = getDocumentDirectory(fileName: PUPILS_SAVE_FILE_NAME)
        try? FileManager().createDirectory(at: pathDirectory, withIntermediateDirectories: true)
        self.savePupilsToLocalFile()
    }
    static func savePupilsToLocalFile(){
        let filePath = getDocumentDirectory(fileName: PUPILS_SAVE_FILE_NAME)
        try? FileManager().createDirectory(at: filePath, withIntermediateDirectories: true)
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(PupilData.pupilModels)
            let jsonString = String(data: jsonData, encoding: .utf8)
            try jsonString?.write(to: filePath, atomically: true, encoding: .utf8)
        }catch{
            print(error.localizedDescription)
        }
    }
    static func getPupilsFromLocalFile() -> [PupilModel]{
        let filePath = getDocumentDirectory(fileName: PUPILS_SAVE_FILE_NAME)
        try? FileManager().createDirectory(at: filePath, withIntermediateDirectories: true)
        var pupilModel: [PupilModel] = []
        let jsonString = try?  String(contentsOf: filePath, encoding: String.Encoding.utf8)
        do{
            if let data:Data = jsonString?.data(using: .utf8){
                pupilModel = try JSONDecoder().decode([PupilModel].self, from: data)
            }
        }catch let error{
            print(error.localizedDescription)
        }
        return pupilModel
    }
   
    
    static func getDocumentDirectory(fileName:String?) -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0].appendingPathComponent(fileName ?? "")
    }
}
