## Cadastro de mapa e da sua malha

 Endpoint: /maps
 Method: POST

 Exemplo de cadastro via curl:
 ~~~

 curl -H 'Content-Type: multipart/form-data' -F "name=Mapa RJ" -F "file=@routes.txt;type=text/plain" -X POST http://localhost:9292/maps -v

~~~

### Parâmetros de entrada

| Nome | Tipo    | Obrigatório | Descrição                                    |
|------|---------|-------------|----------------------------------------------|
| name | String  | Sim         | Nome do mapa                                 |
| file | File    | Sim         | Arquivo contendo as rotas                    |

####Formatação do arquivo

O arquivo deve ser um arquivo texto contendo em cada linha uma rota. Cada rota deve conter um ponto de origem, ponto de destino e distância entre os pontos em quilômetros, separados por
espaços.
Segue abaixo as especificações:

| Nome             | Tipo    | Obrigatório | Formato              | Descrição                        |
|------------------|---------|-------------|----------------------|----------------------------------|
| ponto de origem  | String  | Sim         |                      | Nome do ponto de origem da rota  |
| ponto de destino | String  | Sim         |                      | Nome do ponto de destino da rota |
| distância        | Float   | Sim         | Numerico maior que 0 | Distância em Km entre os pontos  |

### Dados de resposta

#### Status HTTP

| Código           | Descrição                       |
|------------------|---------------------------------|
| 201              | Cadastro efetuado com sucesso   |
| 400              | Parâmetros inválidos            |
| 500              | Erro interno no servidor        |

#### Exemplo de sucesso
Se o mapa foi criado com sucesso, a resposta deve ser somente o status code 201, o corpo da resposta é vazio.


#### Exemplo de erro

~~~
{
    "errors": {
                "name": ["can't be blank"],
                "file": ["can't be blank", "file is invalid"]
    }
}
~~~


## Busca do menor valor de entrega e seu caminho

 Endpoint: /search
 Method: GET

 Exemplo de cadastro via curl:
 ~~~

   curl -X GET "http://localhost:9292/search?name=Mapa%20RJ&source=A&target=E&autonomy=10&price=2.5" -v

~~~

### Parâmetros de entrada
| Nome     | Tipo    | Obrigatório | Descrição                                    |
|----------|---------|-------------|----------------------------------------------|
| name     | String  | Sim         | Nome do mapa                                 |
| source   | String  | Sim         | Nome do ponto de origem                      |
| target   | String  | Sim         | Nome do ponto de destino                     |
| autonomy | Float   | Sim         | Autonomia do caminhão (km/l)                 |
| price    | Float   | Sim         | Valor do litro do combustivel                |

### Dados de resposta

#### Status HTTP

  | Código           | Descrição                       |
  |------------------|---------------------------------|
  | 204              | Alteração efetuada com sucesso  |
  | 400              | Parâmetros inválidos            |
  | 404              | Mapa não encontrado             |
  | 500              | Erro interno no servidor        |

#### Exemplo de sucesso

~~~
{
  "route": "A B D",
  "cost": 6.25
}
~~~

#### Exemplo de erro

~~~
{
    "errors": { "name": ["can't be blank"] }
}
~~~

