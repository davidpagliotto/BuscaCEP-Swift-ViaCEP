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

    @IBAction func consultarCEP(sender: AnyObject) {
        
        let session = NSURLSession.sharedSession()
        
        let urlPath = NSURL(string: "https://viacep.com.br/ws/"+self.txtCEP.text!+"/json")
        let request = NSMutableURLRequest(URL: urlPath!)
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        
        let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            if((error) != nil) {
                print(error!.localizedDescription)
            }else {
                _ = NSString(data: data!, encoding:NSUTF8StringEncoding)
                let _: NSError?
                let jsonResult: AnyObject = try! NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers)
                
                dispatch_async(dispatch_get_main_queue(), {
                    let dic: NSDictionary = (jsonResult as! NSDictionary);
                    
                    if dic.count > 1 {
                        self.preencheDados(jsonResult as! NSDictionary)
                    } else {
                        self.preencheDados(nil)
                    }
                })
            }
        }
        dataTask.resume()
        
    }
    
    func preencheDados(dados:NSDictionary!) {
        
        let x: CGFloat = 20
        var y: CGFloat = 95
        let h: CGFloat = 23
        let w: CGFloat = 1000

        var label: UILabel!;
        if let theLabel = self.view.viewWithTag(1000) as? UILabel {
            label = theLabel
            label.removeFromSuperview()
        } else {
            label = UILabel(frame: CGRectMake(x, y, w, h))
        }
        label.tag = 1000;
        if dados == nil {
            label.text = "";
        } else {
            label.text = "CEP: "+(dados.valueForKey(self.kCep) as! String);
        }
        self.view.addSubview(label)
        y += h;
        
        if let theLabel = self.view.viewWithTag(1001) as? UILabel {
            label = theLabel
            label.removeFromSuperview()
        } else {
            label = UILabel(frame: CGRectMake(x, y, w, h))
        }
        label.tag = 1001;
        if dados == nil {
            label.text = "";
        } else {
            label.text = "Cidade/UF: "+(dados.valueForKey(self.kLocalidade) as! String)+"/"+(dados.valueForKey(self.kUF) as! String);
        }
        self.view.addSubview(label)
        y += h;
        
        if let theLabel = self.view.viewWithTag(1002) as? UILabel {
            label = theLabel
            label.removeFromSuperview()
        } else {
            label = UILabel(frame: CGRectMake(x, y, w, h))
        }
        label.tag = 1002;
        if dados == nil {
            label.text = "";
        } else {
            label.text = "Bairro: "+(dados.valueForKey(self.kBairro) as! String);
        }
        self.view.addSubview(label)
        y += h;
        
        if let theLabel = self.view.viewWithTag(1003) as? UILabel {
            label = theLabel
            label.removeFromSuperview()
        } else {
            label = UILabel(frame: CGRectMake(x, y, w, h))
        }
        label.tag = 1003;
        if dados == nil {
            label.text = "";
        } else {
            label.text = "Logradouro: "+(dados.valueForKey(self.kLogradouro) as! String);
        }
        self.view.addSubview(label)
        y += h;
        
        if let theLabel = self.view.viewWithTag(1004) as? UILabel {
            label = theLabel
            label.removeFromSuperview()
        } else {
            label = UILabel(frame: CGRectMake(x, y, w, h))
        }
        label.tag = 1004;
        if dados == nil {
            label.text = "";
        } else {
            label.text = "Complemento: "+(dados.valueForKey(self.kComplemento) as! String);
        }
        self.view.addSubview(label)
        y += h;
        
        if let theLabel = self.view.viewWithTag(1005) as? UILabel {
            label = theLabel
            label.removeFromSuperview()
        } else {
            label = UILabel(frame: CGRectMake(x, y, w, h))
        }
        label.tag = 1005;
        if dados == nil {
            label.text = "";
        } else {
            label.text = "IBGE: "+(dados.valueForKey(self.kIbge) as! String)+" - GIA: "+(dados.valueForKey(self.kGia) as! String);
        }
        self.view.addSubview(label)
        y += h;
    }
}

