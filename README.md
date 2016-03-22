# Protheus-Advpl-OO-Framework
Se você é desenvolvedor Advpl e gosta ou gostaria de trabalhar com os principios Orientados a Objeto, então o que segue é para você.

Antes de trabalhar com Protheus, eu era desenvolvedor e usava linguagens orientados a objeto como Delphi, Java e C#.

Quando cheguei no mundo do Protheus, me deparei com um framework ERP potente porem, com uma linguagem, o Advpl, usada principalmente na sua forma de programação funcional.

Mais tarde descobri que o Advpl suporta a orientação a objeto então decidi criar um framework que me ajudasse principalmente a manipular os dados do Protheus de uma forma mais simples e limpa (ORM).

<a href="http://www.sigawarepb.com.br/frameworkDoc/Sigaware_FRAMEWORK_modelo_vantagens.pdf" target="_blank">Para ver a diferença entre a programação clássica e o uso do meu framework para manipulação de dados vejam aqui</a>

Para ver um exemplo desta manipulação:
<ul>
  <li> Faça o download do projeto (a forma mais fácil é usar o botão "Download Zip" encima)</li>
  <li> Modifique o fonte SIGEXMOD.prw que esta em Exemplo/Modelo para se adequar a sua base de dados (codExis e codNovo)  </li>
  <li> Compile o projeto </li>
  <li> Execute a função de usuario SIGEXMOD em passo a passo par ver o que esta acontecendo </li>
</ul>

As classes definidas em Exemplo/Modelo/ModeloBase são uma boa base para começar um projeto com o ORM

Alem disto eu adicionei outras funções no framework, entre elas:

<ul>
  <li> Business Logic: Classe de base para implementar as regras de negocio. Aconselho a programar totalmente orientado a objeto ou seja, todo novo projeto sera composto de classes que derivam desta classe.
  <li> Importação CSV: Classe que faz todo o trabalho de leitura de arquivo e escritura na base. Para usar só precisa definir o mapping do arquivo de entrada para tabela </li>
  <li> Coleção e Iterator: Classe que define uma coleção como pode existir em java. </li>
  <li> Test Unitário: Classe que permite definir testes unitários para seus fontes. Muito útil para fazer testes que possam ser repetidos e que não precisem de interface de usuário.</li>
  <li> Update de dicionario: Classe que faz o update do dicionario (tabela, campo, indice, gatilho). Só precisa definir os elementos que podem ser gerados através da rotina padrão do Protheus HSPGERAT(). Esta rotina vai procurar dentro do dicionario os elementos indicados e criar um array. (Vai em formula, inserir, HSPGERAT(), tabulação) </li>
</ul>

Este Framework esta sendo usado em produção em projetos complexos por entanto, ele chegou a um bom nível de maturidade mesmo que, claro, tenha espaço para aprimoramentos.

<a href="http://www.sigawarepb.com.br/frameworkDoc" target="_blank">A documentação esta disponível aqui</a>.

Ainda falta trabalho encima de documentação e exemplos. 

Feedback e críticas construtivas bem-vindas!!!

Abraços
Gilles Koffmann



