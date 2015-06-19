//
//  DetalhesGMViewController.swift
//  Linceu
//
//  Created by Evandro Henrique Couto de Paula on 17/06/15.
//  Copyright (c) 2015 Esdras Bezerra da Silva. All rights reserved.
//

import UIKit

class DetalhesGMViewController: UIViewController {
    
    var elementoRecebido: Int!
    
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var textDescricao: UITextView!
    @IBOutlet weak var botaoEmail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(self.elementoRecebido)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let path = NSBundle.mainBundle().pathForResource("Atores", ofType: "plist")
        
        let dictionary = NSDictionary(contentsOfFile: path!)
        
        let dados = dictionary?.objectForKey("atores") as! [NSArray]
        
        switch (elementoRecebido){
        case 0:
            self.labelTitulo.text = dados[0].objectAtIndex(0) as? String
            
            self.textDescricao.text = dados [0].objectAtIndex(2) as? String
            self.botaoEmail.hidden = true
            
            
            
            break
            
        case 1:
            self.labelTitulo.text = dados[0].objectAtIndex(0) as? String
            
            self.textDescricao.text = dados [0].objectAtIndex(3) as? String
            self.botaoEmail.hidden = true
            
            
            break
            
        case 2:
            self.labelTitulo.text = "Departamentos"
            self.textDescricao.text = "Sem informação"
            self.botaoEmail.hidden = true
            break
            
        case 3:
            self.labelTitulo.text = "Fale Conosco"
            self.textDescricao.hidden = true;
            
            //self.textDescricao.text = dados [0].objectAtIndex(5) as? String
            
            var titulo = dados[0].objectAtIndex(5) as? String
            
            self.botaoEmail.setTitle(titulo, forState: UIControlState.Normal)
            
        default:
            self.labelTitulo.text = "Dados não obtidos"
            
            self.textDescricao.text = "Dados não obtidos"
            
            
        }
        
        
        
        
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
}
