//
//  Plantas.swift
//  Ordeal
//
//  Created by Caio Lopes on 30/11/23.
//

import Foundation

//struct de Modelo de planta
struct IdentifiablePlantas: Identifiable, Hashable{
    let id = UUID()
    let nome: String
    let especie: String
    
//    let imagem: String
        //adicionar logica de transformar String em imagem de perfil
    //adicionar página
    
}

//struct de Dados das plantas
class Plantas: ObservableObject{

    @Published var plantas: [IdentifiablePlantas] =
        [IdentifiablePlantas(nome: "Orquídea", especie: "Orchidaceae"),
         IdentifiablePlantas(nome: "Hortênsia", especie: "Hydrangea macrophylla"),
         IdentifiablePlantas(nome: "Jibóia", especie: "Epipremnum pinnatum"),
         IdentifiablePlantas(nome: "Margarida", especie: "Leucanthemum vulgare"),
         IdentifiablePlantas(nome: "Alecrim", especie: "Rosmarinus officinalis"),
         IdentifiablePlantas(nome: "Bromélia", especie: "Bromeliaceae"),
         IdentifiablePlantas(nome: "Samambaia", especie: "Nephrolepis exaltata")
        ]
    
    //Função para adicionar novas plantas
    func adicionarPlanta(nome: String, especie: String) {
        let novaPlanta = IdentifiablePlantas(nome: nome, especie: especie)
        plantas.append(novaPlanta)
    }
    
    //Função para apagar plantas
    func apagarPlanta(index: IndexSet) {
        plantas.remove(atOffsets: index)
    }
    
    //Função para filtrar as plantas com base na pesquisa do nome
    func filtrarPlantas(por nome: String) -> [IdentifiablePlantas] {
        if nome.isEmpty {
            return plantas
        } else{
            return plantas.filter { $0.nome.lowercased().contains(nome.lowercased())}
        }
    }
    
        /*
         Para apagar uma planta, chamar essa função, vamos usar o comando:
         
         .onDelete(perform: plantaData.apagarPlanta)
         como modificador do ForEach dentro da Section dentro da Lista das plantas existentes
         e em um botão na tela individual da planta
         
         */
    
    /*
     Para acessar o número de plantas existentes use:
     @State var count = plantaData.plantas.count
     */
}
