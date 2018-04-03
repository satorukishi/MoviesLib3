//
//  Movie.swift
//  MoviesLib
//
//  Created by Eric Brito on 26/03/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import Foundation

class Movie {
    var title: String           //Título do filme
    var rating: Double          //Nota
    var summary: String         //Sinopse
    var duration: String        //Duração
    var imageName: String       //Nome base para o arquivo com a imagem do filme
    var categories: [String]!   //Lista de categorias
    
    //Propriedade computada que retornará o arquivo para a imagem na tabela
    var imageSmall: String { return imageName + "-small.jpg" }
    
    //Propriedade computada que retornará o arquivo para a imagem de destaque
    var imageWide: String { return imageName + "-wide.jpg" }
    
    //Propriedade computada que ajudará na apresentação das categorias na tela de detalhes do Filme. O método reduce irá combinar as categorias em uma String
    var categoriesDescription: String {
        return categories.reduce("", {"\($0) | \($1)"})
    }
    
    //Construtor da classe
    init(title: String, rating: Double, summary: String, duration: String, imageName: String) {
        self.title = title
        self.rating = rating
        self.summary = summary
        self.duration = duration
        self.imageName = imageName
    }
}

