//
//  Pupils.swift
//  htc
//
//  Created by Princess Max on 07.02.2019.
//  Copyright © 2019 Princess Max. All rights reserved.
//

import UIKit
class PupilsViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    var pupilIndexToEdit: Int?
    var pupilId = UUID()
    let EditPupilSequeIdentifier = "toEditPupilSeque"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        PupilFunctions.readPupils(completion: {  [weak self] in
            self?.tableView.reloadData()
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.EditPupilSequeIdentifier {
            let popup = segue.destination as! EditPupilViewController
            popup.pupilIndex = self.pupilIndexToEdit
            popup.pupilId = self.pupilId
            popup.doneSaving = { [weak self] in
                guard let self = self else {return}
                self.tableView.reloadData()
            }
            pupilIndexToEdit = nil
        }
    }

}

extension PupilsViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PupilData.pupilModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PupilsTableViewCell.identifier) as! PupilsTableViewCell
        cell.setup(pupilModel: PupilData.pupilModels[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pupil = PupilData.pupilModels[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerfofmed: @escaping (Bool) -> ()) in
            let alert = UIAlertController(title: "Delete user", message: "Are you sure want to delete the user: \(String(describing: pupil.name!))", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                actionPerfofmed(false)
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                PupilFunctions.deletePupil(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                actionPerfofmed(true)
            }))
            self.present(alert, animated: true)
        }
        delete.backgroundColor = Theme.colorRed
        return UISwipeActionsConfiguration(actions: [delete])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pupilIndexToEdit = indexPath.row
        let pupil = PupilData.pupilModels[indexPath.row]
        self.pupilId = pupil.id
        self.pupilIndexToEdit = indexPath.row
        self.performSegue(withIdentifier: self.EditPupilSequeIdentifier, sender: nil)
    }
    
}
