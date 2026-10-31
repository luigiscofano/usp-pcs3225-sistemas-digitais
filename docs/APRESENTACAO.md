# Roteiro de apresentação · PCS3225 · Sistemas Digitais II

## Problema e contexto · 1 minuto

Do algoritmo ao ciclo de clock: BCD, calculadora e datapath RISC-V. Apresente a procedência e identifique o que é recuperado e novo.

## Mecanismo · 3 minutos

Abra [ARQUITETURA.md](ARQUITETURA.md). Explique entradas, estado intermediário e saída em um exemplo pequeno. Relacione diagrama e arquivos reais.

## Demonstração · 3 minutos

Execute [os comandos](INSTALACAO.md), prevendo o resultado antes. Repita com entrada inválida. Explique um teste com referência independente ou invariante.

## Aprendizagem · 2 minutos

Escolha duas competências de [OBJETIVOS_PEDAGOGICOS.md](OBJETIVOS_PEDAGOGICOS.md). Mostre atividade, evidência exigida e uma pergunta que requer entender o mecanismo.

## Evidência e limites · 1 minuto

Mostre [VALIDACAO.md](VALIDACAO.md) e os PRs reais. Limites: Sem síntese Quartus, placa ou pinagem; calculadora com ISA nova e ROM editável; RV32I apenas subconjunto declarado; sem prova formal ou cobertura completa de instruções.

Perguntas: qual hipótese permite a decisão central? Que entrada quebra a versão ingênua? Como separar bug e limite do modelo? Que evidência permitiria ampliar a conclusão?
