Feature: Login
Como um cliente
quero poder acessar minha conta e manter logado
Para que eu possa ver e responder enquetes rápida

CENÁRIO: Credenciais Válidas
Dado que o cliente informou credenciais válidas
Quando solicitar para fazer login
Então o sistema enviar o usuário para a tela de pesquisas
E manter o usuário conectado

CENÁRIO: Credenciais Inválidas
Dado que o cliente informou credenciais inválidas
Quando solicitar  para fazer login
Então o sistema deve retornar uma mensagem de erro