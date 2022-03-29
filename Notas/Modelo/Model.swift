//
//  Model.swift
//  Notas
//
//  Created by MacBook J&J  on 23/03/22.
//

import Foundation
import CoreData
import UIKit

class Modelo {
    
    public static let shared = Modelo()
    
    func contexto() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    func saveData(titulo: String, nota: String, fecha: Date) {
        let context = self.contexto()
        let entityNotas = NSEntityDescription.insertNewObject(forEntityName: "Notas", into: context) as! Notas
        entityNotas.titulo = titulo
        entityNotas.nota = nota
        entityNotas.fecha = fecha
        
        do {
            try context.save()
            print("Guardado exitoso")
        } catch let error as NSError {
            print("NO SE PUDO GUARDAR LA NOTA", error.localizedDescription)
        }
    }
    
    func deleteData(fethedResultController: NSFetchedResultsController<Notas>, indexPath: IndexPath) {
        let context = self.contexto()
        let delete = fethedResultController.object(at: indexPath)
        context.delete(delete)
        do {
            try context.save()
            print("Se elimino la nota \(indexPath.row)")
        } catch let error as NSError {
            print("NO SE HA PODIDO ELIMINAR LA NOTA", error.localizedDescription)
        }
    }
    
    
    func editData(titulo: String, nota: String, fecha: Date, notas: Notas) {
        let context = self.contexto()
        notas.setValue(titulo, forKey: "titulo")
        notas.setValue(nota, forKey: "nota")
        notas.setValue(fecha, forKey: "fecha")
        
        do {
            try context.save()
            print("editado exitoso")
        } catch let error as NSError {
            print("NO SE PUDO EDITAR LA NOTA", error.localizedDescription)
        }
    }
    
    
    
}
