//
//  NoticiasViewController.swift
//  Linceu
//
//  Created by Rodrigo A E Miyashiro on 6/17/15.
//  Copyright (c) 2015 Esdras Bezerra da Silva. All rights reserved.
//

import UIKit

class NoticiasViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewBase: UIView!
    
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()


        var noticias = Noticia()
        
        let todasNoticiasJSON = JSONParser()
        let arrayNoticias: Array<Noticia> = todasNoticiasJSON.parseJSON("informacoes")
        
//        let titulo = arrayNoticias[0].tituloNoticia as String
//        let imagem = arrayNoticias[0].imagemNoticia as String
//        let descricao = arrayNoticias[0].textNoticia as String
        
        
        for array in arrayNoticias {
            let titulo = array.tituloNoticia as String
            let imagem = array.imagemNoticia as String
            let descricao = array.textNoticia as String
            
            self.titulo.text = titulo
            self.imagem.image = UIImage(named: imagem)
            self.descricao.text = descricao
            
            println("Titulo: \(titulo)")
            println("Imagem: \(imagem)")
            println("Descricao: \(descricao)")
            println("\n\n")
        }

        
        
        
        println("Titulo: \(titulo)")
        println("Imagem: \(imagem)")
        println("Descricao: \(descricao)")
        println("\n\n")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
