//
//  ViewController.swift
//  Flags Of The World
//
//  Created by Melis Yazıcı on 09.10.22.
//

import UIKit

class ViewController: UITableViewController {
    
    var smallFlags = [String]()
    var bigFlags = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        var items = try! fm.contentsOfDirectory(atPath: path)

        
        for item in items {
            if item.hasSuffix("2x.png") {
                smallFlags.append(item)
            }
            if item.hasSuffix("3x.png") {
                bigFlags.append(item)
            }
        }
        smallFlags.sort()
        bigFlags.sort()
        

        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smallFlags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        
        let cellImages = cell.imageView
        cellImages?.layer.borderWidth = 1
        cellImages?.layer.borderColor = UIColor.lightGray.cgColor
        cellImages?.image = UIImage(named: smallFlags[indexPath.row])
        
        let flagFileNameWithoutExt = smallFlags[indexPath.row].fileName()
        let flagFileNameArray = flagFileNameWithoutExt.components(separatedBy: "@2x")
        let flagFileName = flagFileNameArray.first!
        let flagNameUppercased = flagFileName.uppercased()
        
        cell.textLabel?.text = flagNameUppercased
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = bigFlags[indexPath.row]
            
            let flagFileNameWithoutExt = bigFlags[indexPath.row].fileName()
            let flagFileNameArray = flagFileNameWithoutExt.components(separatedBy: "@3x")
            let flagFileName = flagFileNameArray.first!
            let flagNameUppercased = flagFileName.uppercased()
            
            vc.title = "\(flagNameUppercased)"
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}


extension String {
    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
}

