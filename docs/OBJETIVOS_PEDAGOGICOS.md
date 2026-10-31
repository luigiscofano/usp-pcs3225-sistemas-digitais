# Objetivos pedagógicos

**A meta é explicar o mecanismo e demonstrar o resultado.** Cada atividade exige evidência observável.

| Competência | Atividade | Evidência de aprendizagem |
| --- | --- | --- |
| Relacionar algoritmo e FSM | Traçar add-3 e shift de 42 | Ler estado, BCD e done em uma forma de onda real |
| Definir handshake | Manter start até done e liberar a próxima operação | Testar estabilidade e reset durante conversão |
| Separar controle e dados | Identificar ROM, ULA e registerfile | Explicar escrita habilitada e caminho do resultado |
| Decodificar instruções | Reconstruir imediatos I/S/B/U/J | Confrontar PC e registradores com programa conhecido |
| Detectar operação ilegal | Executar word inválido e load desalinhado | Verificar trap sem escrita |
| Distinguir simulação e FPGA | Reproduzir testbenches | Explicar o que ainda exige síntese, constraints e placa |

## Sequência de estudo

1. Leia o contrato e resolva um exemplo pequeno à mão.
2. Preveja saída e estado intermediário antes de executar.
3. Confronte sua previsão com o programa.
4. Altere uma entrada de fronteira e justifique o resultado.
5. Explique o invariante violado em um teste negativo.
6. Proponha uma extensão com critério de aceitação.

## Rubrica sugerida

| Critério | Inicial | Adequado | Avançado |
| --- | --- | --- | --- |
| Explicação | Repete a saída | Explica etapas | Justifica invariante e contraexemplo |
| Verificação | Usa um exemplo | Testa fronteiras | Compara com referência independente |
| Limites | Omite hipóteses | Declara domínio | Explica falha e sua detecção |
| Reprodução | Depende do ambiente pessoal | Usa comandos e fixtures | Registra versão, origem e evidência |

Rubrica proposta nesta edição, sem estudo de eficácia pedagógica com participantes ou nota institucional.
