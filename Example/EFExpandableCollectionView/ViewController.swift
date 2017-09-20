//
//  ViewController.swift
//  EFExpandableCollectionView
//
//  Created by ezefranca on 09/20/2017.
//  Copyright (c) 2017 ezefranca. All rights reserved.
//

import UIKit
import EFExpandableCollectionView

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 0, height: 0)
        
        let collectionViewController = EFExpandableCollectionViewController(collectionViewLayout: layout)
        
        collectionViewController.delegate = self
        collectionViewController.collectionView?.register(UINib(nibName:"CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionViewController.collectionView?.backgroundColor = UIColor.white
        
        if let _collectionView = collectionViewController.collectionView {
                self.view.addSubview(_collectionView)
        }
        
        self.addChildViewController(collectionViewController)
        collectionViewController.collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController : EFExpandableCollectionViewDelegate {
    
    func expandableCollectionViewController(numberOfSections in: UICollectionView?) -> Int {
        return 1
    }
    
    func expandableCollectionViewController(_ collectionView: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 20
    }
    
    func expandableCollectionViewController(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        return
    }
    
    func expandableCollectionViewController(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        return cell
    }
    
    func expandableCollectionViewController(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath, isExpanded: Bool) -> CGSize {
        
        if isExpanded {
            return CGSize(width: view.frame.size.width * 0.9, height: view.frame.size.width * 0.90)
        }
        
        return CGSize(width: view.frame.size.width * 0.9, height: view.frame.size.width * 0.50)
        
    }
    
    func expandableCollectionViewController(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return view.frame.size.height * 0.02
    }
    
    func expandableCollectionViewController(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return view.frame.size.height * 0.02
    }
    
    
    func expandableCollectionViewController(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped cell at index \(indexPath.row)")
    }
    
}

