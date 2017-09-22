//
//  ViewController.swift
//  BuscaCEP-Swift
//
//  Created by David Pagliotto on 1/16/17.
//  Copyright © 2017 dpagliotto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtCEP: UITextField!
    
    let kCep: String!         = "cep";
    let kUF: String!          = "uf"
    let kLocalidade: String!  = "localidade"
    let kBairro: String!      = "bairro"
    let kLogradouro: String!  = "logradouro"
    let kComplemento: String! = "complemento"
    let kUnidade: String!     = "unidade"
    let kIbge: String!        = "ibge"
    let kGia: String!         = "gia"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBAction func consultarCEP(_ sender: AnyObject) {
        
        let session = URLSession.shared
        
        let urlPath = URL(string: "https://viacep.com.br/ws/"+self.txtCEP.text!+"/json")
        var request = URLRequest(url: urlPath!)
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
        session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if((error) != nil) {
                print(error!.localizedDescription)
            } else {
                do {
                    _ = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
                    let _: NSError?
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers)
                    
                    DispatchQueue.main.async(execute: {
                        let dic: NSDictionary = (jsonResult as! NSDictionary);
                        
                        if dic.count > 1 {
                            self.preencheDados(jsonResult as! NSDictionary)
                        } else {
                            self.preencheDados(nil)
                        }
                    })
                } catch {
                    DispatchQueue.main.async(execute: {
                        self.preencheDados(nil)
                    })
                }
            }
            
        }).resume()
        
    }
    
    func preencheDados(_ dados:NSDictionary!) {
        
        let x: CGFloat = 20
        var y: CGFloat = 95
        let h: CGFloat = 23
        let w: CGFloat = 1000

        var label: UILabel!;
        if let theLabel = self.view.viewWithTag(1000) as? UILabel {
            label = theLabel
            label.removeFromSuperview()
        } else {
            label = UILabel(frame: CGRect(x: x, y: y, width: w, height: h))
        }
        label.tag = 1000;
        if dados == nil {
            label.text = "";
        } else {
            label.text = "CEP: "+(dados.value(forKey: self.kCep) as! String);
        }
        self.view.addSubview(label)
        y += h;
        
        if let theLabel = self.view.viewWithTag(1001) as? UILabel {
            label = theLabel
            label.removeFromSuperview()
        } else {
            label = UILabel(frame: CGRect(x: x, y: y, width: w, height: h))
        }
        label.tag = 1001;
        if dados == nil {
            label.text = "";
        } else {
            label.text = "Cidade/UF: "+(dados.value(forKey: self.kLocalidade) as! String)+"/"+(dados.value(forKey: self.kUF) as! String);
        }
        self.view.addSubview(label)
        y += h;
        
        if let theLabel = self.view.viewWithTag(1002) as? UILabel {
            label = theLabel
            label.removeFromSuperview()
        } else {
            label = UILabel(frame: CGRect(x: x, y: y, width: w, height: h))
        }
        label.tag = 1002;
        if dados == nil {
            label.text = "";
        } else {
            label.text = "Bairro: "+(dados.value(forKey: self.kBairro) as! String);
        }
        self.view.addSubview(label)
        y += h;
        
        if let theLabel = self.view.viewWithTag(1003) as? UILabel {
            label = theLabel
            label.removeFromSuperview()
        } else {
            label = UILabel(frame: CGRect(x: x, y: y, width: w, height: h))
        }
        label.tag = 1003;
        if dados == nil {
            label.text = "";
        } else {
            label.text = "Logradouro: "+(dados.value(forKey: self.kLogradouro) as! String);
        }
        self.view.addSubview(label)
        y += h;
        
        if let theLabel = self.view.viewWithTag(1004) as? UILabel {
            label = theLabel
            label.removeFromSuperview()
        } else {
            label = UILabel(frame: CGRect(x: x, y: y, width: w, height: h))
        }
        label.tag = 1004;
        if dados == nil {
            label.text = "";
        } else {
            label.text = "Complemento: "+(dados.value(forKey: self.kComplemento) as! String);
        }
        self.view.addSubview(label)
        y += h;
        
        if let theLabel = self.view.viewWithTag(1005) as? UILabel {
            label = theLabel
            label.removeFromSuperview()
        } else {
            label = UILabel(frame: CGRect(x: x, y: y, width: w, height: h))
        }
        label.tag = 1005;
        if dados == nil {
            label.text = "";
        } else {
            label.text = "IBGE: "+(dados.value(forKey: self.kIbge) as! String)+" - GIA: "+(dados.value(forKey: self.kGia) as! String);
        }
        self.view.addSubview(label)
        y += h;
    }
}

