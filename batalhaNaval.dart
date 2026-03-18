import 'dart:io';


// Classe ponto (serve pra guardar uma posição no tabuleiro)
class Ponto {
  int linha;
  int coluna;


  Ponto(this.linha, this.coluna); // --> atribui automático o valor de linha e coluna
}


// inicia tabuleiro
List<List<String>> iniciaTabuleiro(int tamanho) {


  List<List<String>> tabuleiro = [];


  for (int i = 1; i < tamanho; i++) { //faz as linhas inicarem com 1 e irem de 1 em 1


    List<String> linha = [];


    for (int j = 1; j < tamanho; j++) { // mesma coisa que a linha só que com as colunas
      linha.add("~");
    }


    tabuleiro.add(linha);
  }


  return tabuleiro;
}


// mostrar tabuleiro
void mostrarTabuleiro(List<List<String>> tabuleiro){


  print("\nTABULEIRO:");


  for(int i = 1; i < tabuleiro.length; i++){


    for(int j = 1; j < tabuleiro[i].length; j++){
      stdout.write(tabuleiro[i][j] + " ");
    }


    print("");
  }


}


// perguntar tamanho do navio
int tamanhoNavio(String jogador){


  print("${jogador}, digite o tamanho do seu navio:");




  String? input = stdin.readLineSync();


  if(int.tryParse(input.toString()) == null){
    print("Não foi digitado um número");
    exit(0);
  }


  return int.parse(input.toString());
}


// atribui navio
List<Ponto> atribuiNavio(String jogador, int tamanhoTabuleiro){

  int tamanho = tamanhoNavio(jogador);

  // 🔥 VALIDAÇÃO DO TAMANHO DO NAVIO
  while (tamanho > tamanhoTabuleiro) {

    print(" O tamanho do navio é maior que o tabuleiro!");
    print("Digite outro tamanho entre 1 e 16:");

    tamanho = tamanhoNavio(jogador);
  }

  print("${jogador}, escolha a linha inicial do navio (1 a ${tamanhoTabuleiro-1})");
  int linha = int.parse(stdin.readLineSync()!);

  print("${jogador}, escolha a coluna inicial do navio (1 a ${tamanhoTabuleiro-1})");
  int coluna = int.parse(stdin.readLineSync()!);

  //  VALIDAÇÃO DE POSIÇÃO
  while (coluna + tamanho > tamanhoTabuleiro) {

    print("❌ O navio não cabe nessa posição!");
    print("Escolha outra coluna:");

    coluna = int.parse(stdin.readLineSync()!);
  }

  List<Ponto> navio = [];

  for(int i = 0; i < tamanho; i++){
    navio.add(Ponto(linha, coluna + i));
  }

  return navio;
}


// calcular placar
bool calcularPlacar(Ponto ataque, List<Ponto> navio){


  for(int i = 1; i < navio.length; i++){


    if(ataque.linha == navio[i].linha && ataque.coluna == navio[i].coluna){
      return true;
    }


  }


  return false;


}


// run
void run(){


  int tamanho = 16;


  List<List<String>> tabuleiro = iniciaTabuleiro(tamanho);


  print("=== BATALHA NAVAL ===");


  List<Ponto> navioJogador1 = atribuiNavio("Jogador 1", tamanho);


  print("\n\n\n\n\n\n\n\n\n");


  List<Ponto> navioJogador2 = atribuiNavio("Jogador 2", tamanho);


  while(true){


    mostrarTabuleiro(tabuleiro);


    // jogador 1
    print("\nJogador 1 ataque!");


    print("Linha:");
    int linha = int.parse(stdin.readLineSync()!);


    print("Coluna:");
    int coluna = int.parse(stdin.readLineSync()!);


    Ponto ataque = Ponto(linha, coluna);


    if(calcularPlacar(ataque, navioJogador2)){
      tabuleiro[linha][coluna] = "X";
      mostrarTabuleiro(tabuleiro);
      print("💥 Jogador 1 acertou o navio!");
      print("🏆 Jogador 1 venceu!");
      break;
    }else{
      tabuleiro[linha][coluna] = "O";
      print("Água!");
    }


    mostrarTabuleiro(tabuleiro);


    // jogador 2
    print("\nJogador 2 ataque!");


    print("Linha:");
    linha = int.parse(stdin.readLineSync()!);


    print("Coluna:");
    coluna = int.parse(stdin.readLineSync()!);


    ataque = Ponto(linha, coluna);


    if(calcularPlacar(ataque, navioJogador1)){
      tabuleiro[linha][coluna] = "X";
      mostrarTabuleiro(tabuleiro);
      print("💥 Jogador 2 acertou o navio!");
      print("🏆 Jogador 2 venceu!");
      break;
    }else{
      tabuleiro[linha][coluna] = "O";
      print("Água!");
    }


  }


}


void main(){
  run();
}


