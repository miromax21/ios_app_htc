//
//  EditPupil.swift
//  htc
//
//  Created by Princess Max on 07.02.2019.
//  Copyright © 2019 Princess Max. All rights reserved.
//

import UIKit
class EditPupilViewController:UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var gradePointAverage: UITextField!
    
    var doneSaving: (() -> ())?
    var pupil: PupilModel?
    var pupilId:UUID?
    var pupilIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if pupilIndex != nil {
            PupilFunctions.redPupil(by: pupilId!) { [weak self] (model) in
                guard let self = self else {return}
                guard let model = model else {return}
                self.name.text = model.name
                self.lastName.text = model.lastName
                self.gradePointAverage.text = "\(model.gradePointAverage)"
            }
        }
    }
   
    @IBAction func Save(_ sender: Any) {
            if let name = name.text, let lastName = lastName.text, let gradePointAverage = gradePointAverage.text{
                let errors: [InvalideObject] = Validation.shared.validate(values:
                    ValidationObject(type: RegExEnum.name, inputValue: name),
                    ValidationObject(type: RegExEnum.name, inputValue: lastName,lable: "lastName"),
                    ValidationObject(type: RegExEnum.gradePointAverage, inputValue: gradePointAverage))
              
                if errors.count > 0 {
                    var errorMessage = ""
                    for error in errors{
                        errorMessage += "\(error.key): \(error.errorMrssage) \n"
                    }
                    let alert = UIAlertController(title: "Photo Libraty Restricted", message: errorMessage, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(okAction)
                    self.present(alert,animated: true)
                    return
                }
                
                if let index = self.pupilIndex{
                    PupilFunctions.updatePupil(index: index, name: name, last_name: lastName, grade_point_average: Int(gradePointAverage)!)
                }else{
                    PupilFunctions.createPupils(pupil: PupilModel(name: name, last_name: lastName, grade_point_average: Int(gradePointAverage)))
                }
            }
        if let doneSaving = doneSaving{
            doneSaving()
        }
        dismiss(animated: true)
    }
    

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
}
