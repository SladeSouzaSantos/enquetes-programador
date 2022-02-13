#HTTP

> ## Sucesso
1. Request com verbo http válido (post) (X)
2. Passar nos headers o content type JSON (X)
3. Chamar request com body correct (X)
4. Ok - 200 e resposta com dados (X)
5. No content - 204 e resposta sem dados (X)

> ## Erros
1. Bad request - 400 (X)
2. Unauthorized - 401 (X)
3. For bidden - 403 (X)
4. Not found - 404 (X)
5. Internal server error - 500 (X)

> ## Exceção - Status code diferente dos citados acima
1. Internal server error - 500 (X)

> ## Exceção - Http request deu alguma exceção
1. Internal server error - 500 (X)

> ## Exceção - Verbo http inválido
1. Internal server error - 500 (X)