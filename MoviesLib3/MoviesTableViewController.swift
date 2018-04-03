//
//  MoviesTableViewController.swift
//  MoviesLib
//
//  Created by Eric on 24/03/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    //Objeto que conterá o conjunto de Filmes que será usado na tableview
    var dataSource: [Movie] = []
    
    //Criando nossa label que será a backgroundView da tabela
    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocalJSON() //Alimentando nosso dataSource
        
        tableView.estimatedRowHeight = 106  //Definindo um tamanho base para o cálculo do tamanho final
        tableView.rowHeight = UITableViewAutomaticDimension //Definindo que o tamanho será dinâmico

        //Definindo os valores das propriedades da lavel
        label.text = "Sem filmes"
        label.textAlignment = .center
        label.textColor = .white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MovieViewController
        vc.movie = dataSource[tableView.indexPathForSelectedRow!.row]
    }


    //Método que fará a leitura (parse) do JSON e alimentará o objeto dataSource
    func loadLocalJSON() {
        
        //Recuperando URL onde se encontra localmente o arquivo movies.json
        if let jsonURL = Bundle.main.url(forResource: "movies", withExtension: "json") {
            
            //Gerando arquivo Data a partir do arquivo movies.json
            let data: Data = try! Data(contentsOf: jsonURL)
            
            //Deserializando o JSON e convertendo em Array de Dicionários. Usamos o objeto data
            //contendo o JSON e .ReadingOptions() como valor padrão de leitura e tratamento desse JSON
            let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [[String: Any]]
            
            for item in json {  //Percorrendo Array de itens do json
                
                //Recuperando informações do JSON e convertendo em objetos locais
                let title = item["title"] as! String
                let duration = item["duration"] as! String
                let summary = item["summary"] as! String
                let imageName = item["image_name"] as! String
                let rating = item["rating"] as! Double
                
                //Criando objeto Movie a partir das informações extraídas do JSON
                let movie = Movie(title: title, rating: rating, summary: summary, duration: duration, imageName: imageName)
                movie.categories = item["categories"] as! [String]
                
                dataSource.append(movie)    //Alimentando array de Movie (dataSource)
            }
            tableView.reloadData()  //Método usado para recarregar os itens de uma tabela
        }
    }

    // MARK: - Table view data source

    //Método que define a quantidade de seções de uma tableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Método que define a quantidade de células para cada seção de uma tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Caso nosso dataSource seja 0, teremos a label aparecendo.
        tableView.backgroundView = dataSource.count == 0 ? label : nil
        
        return dataSource.count //Retornamos o total de itens no nosso dataSource
    }
    
    //Método que define a célula que será apresentada em cada linha
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Definimos o identifier que usamos em nossa célula (movieCell)
        //Fazemos o cast para MovieTableViewCell para que possamos acessar os
        //IBOutlets criados
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        
        //Atribuindo os valores de acordo com os dados recuperados de cada Movie
        //Recuperamos o Movie usando a propriedade row do indexPath da célula em questão
        cell.ivPoster.image = UIImage(named: dataSource[indexPath.row].imageSmall)
        cell.lbTitle.text = dataSource[indexPath.row].title
        cell.lbRating.text = "\(dataSource[indexPath.row].rating)"
        cell.lbSummary.text = dataSource[indexPath.row].summary
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
