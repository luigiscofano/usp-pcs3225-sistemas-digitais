# Experimentos e critérios de aceitação

## Exercício guiado

Execute os exemplos de [INSTALACAO.md](INSTALACAO.md) e anote a previsão antes de rodar. A saída só conta como evidência depois de comparada com o contrato de [ARQUITETURA.md](ARQUITETURA.md).

## Casos de fronteira e referência

1.005 conversões W18; 256 conversões W8 exaustivas; reset e handshake; programa 5+7 da calculadora; programa RV32 com memória, branches, saltos, ULA, x0 e traps. Cobertura por cenários, sem certificação ISA.

Leia a suíte e escolha um caso que quebra uma solução ingênua. Explique o motivo, reduza a entrada ao menor contraexemplo e proponha uma correção sem alterar o contrato silenciosamente. Use referência independente quando disponível.

## O que não concluir

Sem síntese Quartus, placa ou pinagem; calculadora com ISA nova e ROM editável; RV32I apenas subconjunto declarado; sem prova formal ou cobertura completa de instruções.

Não use tempo isolado ou gráfico atraente como prova de correção. Registre ambiente, entrada, saída, versão e limitações relevantes.
