### 🚀 Smart Rockets - Algoritmos Genéticos com LOVE2D

Este projeto demonstra como **algoritmos genéticos** podem ser usados para ensinar foguetes (rockets) a **alcançar um alvo** por conta própria, apenas com tentativa, erro, e evolução. Tudo isso utilizando **LOVE2D (Lua)** para renderização e simulação física.

---

## 🧠 Aplicações no Mundo Real

Este projeto é uma **simulação didática**, mas representa problemas reais em que **soluções precisam ser encontradas sem instruções explícitas**. Exemplos:

- 🛰️ **Controle de trajetória em sondas espaciais**
- 🤖 **Robótica autônoma** — ensinar robôs a se locomoverem até um ponto alvo
- 🚗 **Veículos autônomos** — encontrar rotas com obstáculos
- 🧬 **Otimização evolutiva** — resolver problemas onde não há solução direta, apenas por tentativa e avaliação

---

## 🕹️ Como Funciona

- Cada "foguete" tem um **DNA**, que é uma sequência de vetores de força aplicados ao longo do tempo.
- Esses vetores são inicialmente aleatórios.
- A cada geração, os foguetes:
  1. Aplicam suas forças (genes) para tentar chegar ao alvo
  2. São avaliados com uma **função de fitness** baseada na distância ao alvo
  3. Os melhores são selecionados para se reproduzir (crossover + mutação)
- Foguetes que chegam ao alvo recebem **um bônus de fitness**.

---

## 🔧 Como Rodar

- Faça o download do zip de release no repositorio, extraia e execute o mooncrasher.exe.

#### Como alternativa

- Instale o [LOVE2D](https://love2d.org)
- Adicione a pasta onde o love foi instalado nas variaveis de ambiente PATH, por padrão localizado em: C:\Program Files\LOVE
- Clone o repositório:
  ```bash
  git clone https://github.com/Ocinai/fiap-ia-tech-chall-2
  cd fiap-ia-tech-chall-2
  love . 
  ```
