import 'dart:io';

class Ponto {
  int x;
  int y;

  Ponto(this.x, this.y);
}

// 1° função → iniciar tabuleiro
List<List<String>> iniciarTabuleiro() {
  return List.generate(16, (i) => List.generate(16, (j) => "~"));
}

// mostrar tabuleiro
void mostrarTabuleiro(List<List<String>> tabuleiro) {

  print("\n    1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16");

  for (int i = 0; i < 16; i++) {

    if (i + 1 < 10) {
      print("${i + 1}  ${tabuleiro[i].join("  ")}");
    } else {
      print("${i + 1} ${tabuleiro[i].join("  ")}");
    }

  }
}

// ler posição com limite
int lerPosicao(String mensagem) {

  int valor;

  while (true) {

    print(mensagem);

    valor = int.parse(stdin.readLineSync()!);

    if (valor >= 1 && valor <= 16) {
      return valor - 1;
    }

    print("Posição inválida! Digite entre 1 e 16.");

  }

}

// 2° função → atribuir navio
Ponto atribuirNavio(List<List<String>> tabuleiro, String simbolo) {

  int tamanhoNavio = 3;

  print("\nJogador $simbolo - POSICIONE SEU NAVIO");

  int linha = lerPosicao("Escolha a linha:");
  int coluna = lerPosicao("Escolha a coluna inicial:");

  while (coluna + tamanhoNavio > 16) {

    print("Navio não cabe nessa posição.");
    coluna = lerPosicao("Escolha outra coluna:");

  }

  for (int i = 0; i < tamanhoNavio; i++) {
    tabuleiro[linha][coluna + i] = simbolo;
  }

  print("Navio posicionado!");

  return Ponto(linha, coluna);
}

// esconder navios
void esconderNavios(List<List<String>> tabuleiro) {

  for (int i = 0; i < 16; i++) {
    for (int j = 0; j < 16; j++) {

      if (tabuleiro[i][j] == "A" || tabuleiro[i][j] == "B") {
        tabuleiro[i][j] = "~";
      }

    }
  }

}

// 4° função → placar
void placar(int p1, int p2) {

  print("\n===== PLACAR =====");
  print("Jogador 1: $p1");
  print("Jogador 2: $p2");

}

// 3° função → começar jogo
void comecarJogo(List<List<String>> tabuleiro, Ponto navioA, Ponto navioB) {

  int pontos1 = 0;
  int pontos2 = 0;
  bool jogoAtivo = true;

  while (jogoAtivo) {

    mostrarTabuleiro(tabuleiro);

    print("\n--- VEZ DO JOGADOR 1 ---");

    int linha = lerPosicao("Digite a linha do ataque:");
    int coluna = lerPosicao("Digite a coluna do ataque:");

    if (linha == navioA.x && coluna >= navioA.y && coluna < navioA.y + 3) {

      print("Você acertou seu próprio navio!");
      tabuleiro[linha][coluna] = "X";

    } 
    else if (linha == navioB.x && coluna >= navioB.y && coluna < navioB.y + 3) {

      print("Jogador 1 acertou o navio inimigo!");
      tabuleiro[linha][coluna] = "X";
      pontos1++;
      jogoAtivo = false;

    } 
    else {

      print("Água");
      tabuleiro[linha][coluna] = "O";

    }

    if (!jogoAtivo) break;

    mostrarTabuleiro(tabuleiro);

    print("\n--- VEZ DO JOGADOR 2 ---");

    linha = lerPosicao("Digite a linha do ataque:");
    coluna = lerPosicao("Digite a coluna do ataque:");

    if (linha == navioB.x && coluna >= navioB.y && coluna < navioB.y + 3) {

      print("Você acertou seu próprio navio!");
      tabuleiro[linha][coluna] = "X";

    } 
    else if (linha == navioA.x && coluna >= navioA.y && coluna < navioA.y + 3) {

      print("Jogador 2 acertou o navio inimigo!");
      tabuleiro[linha][coluna] = "X";
      pontos2++;
      jogoAtivo = false;

    } 
    else {

      print("Água");
      tabuleiro[linha][coluna] = "O";

    }

    placar(pontos1, pontos2);

  }

  print("\n===== FIM DO JOGO =====");

  mostrarTabuleiro(tabuleiro);

  placar(pontos1, pontos2);

}

void main() {

  var tabuleiro = iniciarTabuleiro();

  mostrarTabuleiro(tabuleiro);

  print("\n POSICIONE SEUS NAVIOS:)");

  Ponto navioA = atribuirNavio(tabuleiro, "A");
  Ponto navioB = atribuirNavio(tabuleiro, "B");

  esconderNavios(tabuleiro);

  comecarJogo(tabuleiro, navioA, navioB);

}