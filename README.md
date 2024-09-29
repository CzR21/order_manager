# Desafio Dev Mobile - Flutter

Este projeto é uma aplicação desenvolvida como parte do Desafio Dev Mobile, que visa avaliar as habilidades de lógica e técnicas no desenvolvimento de aplicações móveis com Flutter. O projeto consiste na implementação de uma aplicação que consome uma API de pedidos, gerencia e persiste dados, e exibe relatórios.

**Observação**: O projeto foi programado para rodar em dispositivos desktop, garantindo uma experiência de usuário otimizada tanto em sistemas Windows, Linux quanto em Mac.

## Principais Funcionalidades do Sistema

O sistema oferece diversas funcionalidades que melhoram a experiência do usuário e a eficiência na manipulação de dados. As principais funcionalidades incluem:

- **Sincronização de Dados via API**: O aplicativo se comunica com uma API para buscar e atualizar dados de pedidos, garantindo que as informações estejam sempre atualizadas e disponíveis.

- **Persistência Local**: Utilizando o Hive ou Floor, o sistema armazena dados localmente, permitindo acesso rápido e offline às informações mais recentes.

- **Listagem de Dados**: Os usuários podem visualizar uma lista detalhada de pedidos, com informações como número do pedido, data, cliente, status e valor total, facilitando a consulta e o gerenciamento.

- **Geração de Relatórios**: A aplicação oferece funcionalidades para gerar relatórios detalhados, permitindo que os usuários analisem vendas, produtos mais vendidos e formas de pagamento.

- **Visualização de Gráficos**: O sistema inclui gráficos que proporcionam uma representação visual dos dados, facilitando a interpretação das informações e a tomada de decisões.


## Principais packages utilizados

- **GetX**: Para gerenciamento de estado e injeção de dependência.
- **Floor**: Para persistência de dados.
- **Dio**: Para consumo e chamadas de API.
- **Excel**: Para exportar relatórios em planilhas Excel.
- **Syncfusion Flutter Charts**: Para visualização de dados em gráficos interativos.


## Como Rodar o Projeto

1. **Clonar o Repositório**:

   Clone o projeto para a sua máquina local usando o comando:
     ```bash
     git clone https://github.com/CzR21/order_manager.git
     ```

2. **Entrar na Pasta do Projeto**:

   Acesse a pasta do projeto com o seguinte comando:
     ```bash
     cd order_manager
     ```

3. **Instalação das Dependências**:

   Execute o comando abaixo para instalar todas as dependências necessárias do Flutter:
     ```bash
     flutter pub get
     ```

4. **Gerar Arquivos Necessários**:

   Execute o seguinte comando para gerar arquivos necessários:
     ```bash
     flutter pub run build_runner build
     ```

5. **Rodando o Projeto**:

   Para rodar o projeto, utilize o comando abaixo no terminal. Ele permite rodar o aplicativo em diferentes plataformas (Windows, Linux, ou Mac):
     ```bash
     flutter run
     ```


## Estrutura do Projeto
O projeto foi estruturado utilizando o padrão **MVVM** para manter a separação clara entre lógica de negócios e apresentação. O **GetX** foi usado para gerenciamento de estado, facilitando a manipulação de dados e a comunicação entre as camadas.

- **daos/**: Diretório destinado a objetos de acesso a dados (Data Access Objects). Ele lida com a lógica de persistência de dados, seja por meio de consultas ao banco de dados ou manipulação de informações salvas localmente.

- **data/**:
    - **entities/**: Contém as classes que representam as entidades do domínio. Essas classes mapeiam os dados que são manipulados e persistidos.
    - **models/**: Contém os modelos de dados que serão utilizados na aplicação, como resposta de APIs ou para mapear dados entre camadas.

- **extentions/**: Esta pasta contém extensões de funcionalidades.

- **helpers/**: Inclui classes utilitárias e funções auxiliares que ajudam na lógica do negócio ou na manipulação de dados.

- **repositories/**: Gerencia as fontes de dados externas da aplicação (Consumo de API's, Websockets...).

- **services/**: Contém os serviços da aplicação que encapsulam a lógica de negócios. Aqui é onde as operações mais complexas e integradas com APIs externas são implementadas.

- **settings/**: Diretório que armazena arquivos de configuração e constantes globais da aplicação. Por exemplo:
    - `app_api.dart`: Configurações e endpoints da API.
    - `app_assets.dart`: Referências a imagens, ícones e outros recursos estáticos.
    - `app_colors.dart`: Definições de paleta de cores usada no app.
    - `app_database.dart`: Configuração do banco de dados.
    - `app_routes.dart`: Definições de rotas de navegação.

- **ui/**:
    - **components/**: Contém componentes reutilizáveis da interface do usuário, como botões, cards, etc.
    - **pages/**: Organiza as diferentes páginas ou telas do aplicativo.

- **utils/**: Contém utilitários que fornecem métodos ou classes genéricas utilizadas em várias partes do projeto.

## Conclusão
Esta aplicação serve como um exemplo de boas práticas no desenvolvimento Flutter, abordando temas como persistência de dados, gerenciamento de estado, componentização e estruturação de widgets e organização de código em padrões de design.
