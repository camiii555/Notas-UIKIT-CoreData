//
//  AddViewController.swift
//  Notas
//
//  Created by MacBook J&J  on 23/03/22.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var titulo: UITextField!
    @IBOutlet weak var nota: UITextView!
    @IBOutlet weak var fecha: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    var notas: Notas?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = notas != nil ? "Editar Notar" : "Crear Nota"
        
        titulo.text = notas?.titulo
        nota.text = notas?.nota
        fecha.date = notas?.fecha ?? Date()
        if notas == nil {
            validateText()
        } else {
            validateTextForEdit()
        }
    }
    
    @IBAction func guardar(_ sender: Any) {
        if notas != nil {
            Modelo.shared.editData(titulo: titulo.text ?? "", nota: nota.text, fecha: fecha.date, notas: notas!)
            
        } else {
            Modelo.shared.saveData(titulo: titulo.text ?? "", nota: nota.text, fecha: fecha.date)
        }
        
        navigationController?.popViewController(animated: true)
       
    }
    
    func validateText() {
        saveButton.isEnabled = false
        saveButton.backgroundColor = .systemGray2
        titulo.addTarget(self, action: #selector(validateTextField) , for: .editingChanged)
    }
    
    func validateTextForEdit() {
        titulo.addTarget(self, action: #selector(validateTextField) , for: .editingChanged)
    }
    
    @objc func validateTextField(sender: UITextField) {
        guard let titulo2 = titulo.text, !titulo2.isEmpty else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = .systemGray2
            return
        }
        saveButton.isEnabled = true
        saveButton.backgroundColor = .cyan
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
}
