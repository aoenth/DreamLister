//
//  ItemDetailVC.swift
//  DreamLister
//
//  Created by Kevin on 2017-05-25.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit
import CoreData
import MBProgressHUD

class ItemDetailVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var thumbImage: UIImageView!

    var stores = [Store]()
    var itemTypes = [ItemType]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self


        getStoresTypes()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveData()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return stores.count
        } else {
            return itemTypes.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // update when selected
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if component == 0 {
            var label: UILabel
            if let lbl = view as? UILabel {
                label = lbl
            } else {
                label = UILabel()
            }
            
            let data = stores[row].name
            let title = NSAttributedString(string: data, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.regular)])
            label.attributedText = title
            
            return label
        } else {
            var label: UILabel
            if let lbl = view as? UILabel {
                label = lbl
            } else {
                label = UILabel()
            }
            
            let data = itemTypes[row].type
            let title = NSAttributedString(string: data, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.regular)])
            label.attributedText = title
            
            return label
        }
    }
    
    func getStoresTypes() {
        let fetchRequest:NSFetchRequest<Store> = Store.fetchRequest()
        let fetchRequestItem:NSFetchRequest<ItemType> = ItemType.fetchRequest()
        var stores = [Store]()
        var itemTypes = [ItemType]()
        do {
            stores = try context.fetch(fetchRequest)
            itemTypes = try context.fetch(fetchRequestItem)
            
        } catch {
            ErrorMessageView.show(errorMessage: "Cannot fetch Store Types", on: self.view)
            return
        }
        
        self.stores = stores.sorted()
        self.itemTypes = itemTypes.sorted()
        self.storePicker.reloadAllComponents()
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        saveData()
    }
    
    private func saveData() {
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumbImage.image
        
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            item.title = title
        }
        
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsField.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        item.toItemType = itemTypes[storePicker.selectedRow(inComponent: 1)]
        
        ad.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func loadItemData() {
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            
            thumbImage.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                } while (index < stores.count)
            }
            
            if let itemType = item.toItemType {
                var index = 0
                repeat {
                    let i = itemTypes[index]
                    if i.type == itemType.type {
                        storePicker.selectRow(index, inComponent: 1, animated: false)
                        break
                    }
                    index += 1
                } while (index < itemTypes.count)
            }
        }
    }
    @IBAction func deletePressed(_ sender: Any) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: Any) {
        present(imagePicker, animated:  true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            thumbImage.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
}
