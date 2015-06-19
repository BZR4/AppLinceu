//
//  SegurancaCidada.swift
//  Linceu
//
//  Created by Esdras Bezerra da Silva on 31/05/15.
//  Copyright (c) 2015 Esdras Bezerra da Silva. All rights reserved.
//

import UIKit


class SegurancaCidada: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var indice = 0;
    
    @IBOutlet weak var segCidadaTextView: UITextView!
    @IBOutlet weak var tableViewInstituicoes: UITableView!
    
 
    let instituicoes = ["Policia militar", "SAMU", "Bombeiros"]
    
    let textCellIdentifier = "TextCell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewInstituicoes.dataSource = self
        tableViewInstituicoes.delegate = self
        
        println("Indice: \(indice)")
            
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -table view
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return instituicoes.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let celula = tableViewInstituicoes.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let linha = indexPath.row
        celula.textLabel?.text = instituicoes[linha]
        
        
        return celula
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        println(self.instituicoes[indexPath.row])
        
        //performSegueWithIdentifier("segueDetalhes", sender: self)
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(tableView .isEqual(self.tableViewInstituicoes)){
            switch(section){
            case 0:
                return "Instituições Importantes"
            default: " "
            }
        }
        return ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        if segue.identifier == "segueDetalhes"
        {
            let indexPath:NSIndexPath = self.tableViewInstituicoes.indexPathForSelectedRow()!
            let destination = segue.destinationViewController as! DetalhesSegurancaCidada
            destination.tableIndex = tableViewInstituicoes.indexPathForSelectedRow()?.row
        }
    }


    
}