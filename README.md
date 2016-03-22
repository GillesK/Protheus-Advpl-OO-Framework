# Protheus-Advpl-OO-Framework
Este projeto é um framework orientado a objeto para Totvs Microsiga Protheus Advpl que cobre os seguintes tópicos: ORM, importação CSV, Coleção, Test Unitário, update de dicionario e mais. 

Este Framework esta sendo usado em produção em projetos complexos por entanto, ele chegou a um bom nível de maturidade mesmo que, claro, tenha espaço para aprimoramentos.

O ORM é o elemento do framework que vai ter o impacto maior sobre como você vai escrever seu fonte (aliado ao uso de classes). Veja <a href="http://www.sigawarepb.com.br/frameworkDoc/Sigaware_FRAMEWORK_modelo_vantagens.pdf" target="_blank">aqui</a> uma discussão sobre as vantagens do ORM. 

Para ver um exemplo do ORM:
<ul>
  <li> Faça o download do projeto </li>
  <li> Modifique o fonte SIGEXMOD.prw que esta em Exemplo/Modelo para se adequar a sua base de dados (codExis e codNovo)  </li>
  <li> Compile o projeto </li>
  <li> Execute a função de usuario SIGEXMOD em passo a passo par ver o que esta acontecendo </li>
</ul>

As classes definidas em Exemplo/Modelo/ModeloBase são uma boa base para começar um projeto com o ORM

Os outros elementos são utilidades que vão ajudar no seu projeto:
<ul>
  <li> Importação CSV: Classe que faz todo o trabalho de leitura de arquivo e escritura na base. Para usar só precisa definir o mapping do arquivo de entrada para tabela </li>
  <li> Coleção e Iterator: Classe que define uma coleção como pode existir em java. </li>
  <li> Test Unitário: Classe que permite definir testes unitários para seus fontes. Muito útil para fazer testes que possam ser repetidos e que não precisem de interface de usuário.</li>
  <li> Update de dicionario: Classe que faz o update do dicionario (tabela, campo, indice, gatilho). Só precisa definir os elementos que podem ser gerados através da rotina padrão do Protheus HSPGERAT(). Esta rotina vai procurar dentro do dicionario os elementos indicados e criar um array. (Vai em formula, inserir, HSPGERAT(), tabulação) </li>
</ul>

A documentação esta disponível <a href="http://www.sigawarepb.com.br/frameworkDoc" target="_blank">aqui</a>.

Ainda falta trabalho encima de documentação e exemplos. 

Feedback e críticas construtivas bem-vindas!!!



