//
//  ThirdViewController.swift
//  Music
//
//  Created by Matt Dickey on 1/21/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var artistPicker: UIPickerView!
    @IBOutlet weak var labelResult: UILabel!
    let artistComponent = 0
    let albumComponent = 1
    var artistAlbums : [String:[String]]!
    var artists: [String]!
    var albums : [String]!
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == artistComponent{
            return artists.count
        }else {
            return albums.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == artistComponent{
            return artists[row]
        }else{
            return albums[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let artistRow = pickerView.selectedRowInComponent(artistComponent)
        let albumRow = pickerView.selectedRowInComponent(albumComponent)
        
        if component == artistComponent{
            let selectedArtist = artists[row]
            albums = artistAlbums[selectedArtist]
            artistPicker.reloadComponent(albumComponent)
            artistPicker.selectRow(0, inComponent: albumComponent, animated: true)
        }
        
        labelResult.text = "You like \(albums[albumRow]) by \(artists[artistRow])."
        
    }
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        labelResult.text = ""
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("artistalbums", ofType: "plist")
        print(path)
        
        artistAlbums = NSDictionary(contentsOfFile: path!) as! [String:[String]]
        print(artistAlbums)
        
        artists = Array(artistAlbums.keys)
        print(artists)
        
        albums = artistAlbums[artists[0]]! as [String]
        print(albums)

    }
    

}
