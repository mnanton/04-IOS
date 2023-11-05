//
//  NetworkModel.swift
//  DBHeroes
//
//  Created by Miguel Nantón Díaz on 26/9/23.
//

import Foundation

final class NetworkModel {
    enum NetworkError: Error,Equatable {
        case unknown
        case malformedURL
        case decodingFailed
        case encodingFailed
        case noData
        case statusCode(code: Int?)
        case noToken
    }
    
    /*
     Descomponemos la dirección de la API, en su raíz
     <https://dragonball.keepcoding.education>/api/auth/login
     */
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    private var token: String? {
        get {
            if let token = LocalDataModel.getToken() {
                return token
            }
            return nil
        }
        set{
            if let token = newValue {
                LocalDataModel.saveToken(token: token)
            }
        }
    }
    
    private let session: URLSession
    init(session: URLSession = .shared){
        self.session = session
    }
    
    func login(
        user: String,
        password: String,
        // completion: @escaping (String?,NetworkError?)-> Void
        completion: @escaping (Result<String,NetworkError>)-> Void
    ){
      
        /*
         Añadimos la función de la carpeta de la API, api/auth/login
         https://dragonball.keepcoding.education</api/auth/login>
         */

        var components = baseComponents
        components.path = "/api/auth/login"
        
        guard let url = components.url else {
            //completion(nil,.malformedURL)
            completion(.failure(.malformedURL))
            return
        }
        
        // Cadena con los valores de acceso, y conversión a base64
        let loginString = String(format: "%@:%@", user,password)
        guard let loginData = loginString.data(using: .utf8) else {
            //completion(nil,.decodingFailed)
            completion(.failure(.decodingFailed))
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        // Método y Header
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        // Singleton
        let  task = session.dataTask(with: request) {[weak self] data, response, error in
            guard error == nil else {
                // completion(nil,.unknown)
                completion(.failure(.unknown))
                return
            }
            
            guard let data = data else {
                //completion(nil,.noData)
                completion(.failure(.noData))
                return
            }
            
            let urlResponse = response as? HTTPURLResponse
            let statusCode = urlResponse?.statusCode
            
            guard statusCode == 200 else {
                //completion(nil,.statusCode(code: statusCode))
                completion(.failure(.statusCode(code: statusCode)))
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                //completion(nil,.decodingFailed)
                completion(.failure(.decodingFailed))
                return
            }
            completion(.success(token))
            self?.token = token
        }
        task.resume()
    }
    
    
    // MARK - Función para recuperar Listado de Heroes
    func getHeroes(completion:@escaping(Result<[Hero],NetworkError>)-> Void ) {
        
        var components = baseComponents
        components.path = "/api/heros/all"
        
        // Verificamos si tenemos URL correcta
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
         guard let token else {
             completion(.failure(.noToken))
            return
        }
                   
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]
        
        // Creación Objeto request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = urlComponents.query?.data(using: .utf8)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.unknown))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            guard let heroes = try? JSONDecoder().decode([Hero].self, from: data) else {
                completion(.failure(.decodingFailed))
                return
            }
            completion(.success(heroes))
        }
        task.resume()
    }
    
    // MARK - Función para recuperar Listado de Transformaciones
    
    func getTransformation(for hero: Hero, 
                           completion: @escaping (Result<[Transformation], NetworkError>) -> Void ) {
        
        // 3ª Fase, crear URL
        var components = baseComponents
        components.path = "/api/heros/tranformations"
        
        // Verificamos si tenemos URL correcta
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        // Verificamos si tenemos Token
        guard let token else {
            completion(.failure(.noToken))
           return
       }
        
  
        
        // 4ª Fase, creación del Body para la petición
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "id", value: hero.id)]
                
        // 2ª Fase, Creación Objeto request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Header
        request.httpBody = urlComponents.query?.data(using: .utf8)
        
        // 1ª Fase, crear DataTask
        createTask(for: request, using: [Transformation].self, completion: completion)
        }
    
    
    func createTask<T: Decodable>(
        for request: URLRequest,
        using type: T.Type,
        completion: @escaping (Result<T, NetworkError>)->Void){
        
            let task = session.dataTask(with: request) { data, response, error in
                
                let result: Result<T, NetworkError>
                
                defer {
                    completion(result)
                }
                
                guard error == nil else {
                    result = .failure(.unknown)
                    return
                }
            
                
                guard let data else {
                    result = .failure(.noData)
                return
                }
                
                guard let resource = try? JSONDecoder().decode(type, from: data) else {
                    result = .failure(.decodingFailed)
                    return
                }
                
                result = .success(resource)
            }
            task.resume()
    }
}
