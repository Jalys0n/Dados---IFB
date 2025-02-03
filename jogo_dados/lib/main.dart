import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const AventuraDosDados());
}

class AventuraDosDados extends StatelessWidget {
  const AventuraDosDados({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('🎲 Aventura dos Dados 🏰'),
          centerTitle: true,
        ),
        body: const JogoDeAventura(),
      ),
    );
  }
}

class JogoDeAventura extends StatefulWidget {
  const JogoDeAventura({super.key});

  @override
  _JogoDeAventuraState createState() => _JogoDeAventuraState();
}

class _JogoDeAventuraState extends State<JogoDeAventura> {
  final Random random = Random();
  int xp = 0, ouro = 0, vida = 100;
  String mensagem = "🎲 Role o dado para iniciar sua aventura!";
  bool enfrentandoChefe = false;
  int resultadoDado = 1;
  bool venceu = false;

  void jogarDado() {
    setState(() {
      resultadoDado = random.nextInt(6) + 1;
      mensagem = "🎲 Você rolou um $resultadoDado!";

      if (venceu) return;

      if (enfrentandoChefe) {
        lutarContraChefe();
      } else {
        eventoAleatorio();
      }

      verificarEstadoDoJogo();
    });
  }

  void eventoAleatorio() {
    int evento = random.nextInt(4);

    if (evento == 0) {
      int ouroGanho = resultadoDado * 5;
      ouro += ouroGanho;
      mensagem += " 💰 Você encontrou um tesouro e ganhou $ouroGanho moedas!";
    } else if (evento == 1) {
      int dano = resultadoDado * 3;
      vida = max(vida - dano, 0);
      mensagem += " ⚔️ Você caiu em uma armadilha e perdeu $dano de vida!";
    } else if (evento == 2) {
      int xpGanho = resultadoDado * 4;
      xp += xpGanho;
      mensagem += " 📜 Você encontrou um pergaminho mágico e ganhou $xpGanho XP!";
    } else {
      int danoInimigo = random.nextInt(10) + 10;
      vida = max(vida - danoInimigo, 0);
      mensagem += " 🐺 Um lobo atacou! Você perdeu $danoInimigo de vida!";
    }

    if (xp >= 50) {
      enfrentandoChefe = true;
      mensagem += " 🐉 Um dragão apareceu! Derrote-o para vencer!";
    }
  }

  void lutarContraChefe() {
    int danoDragao = random.nextInt(20) + 10;
    int danoJogador = resultadoDado * 6;
    vida = max(vida - danoDragao, 0);
    mensagem += " 🐉 O dragão atacou! Você perdeu $danoDragao de vida!";

    if (vida > 0) {
      mensagem += " ⚔️ Você contra-atacou e causou $danoJogador de dano!";
      xp += danoJogador;
    }
  }

  void usarPocao() {
    setState(() {
      if (ouro >= 10) {
        ouro -= 10;
        vida = min(vida + 20, 100);
        mensagem = "🧪 Você usou uma poção e recuperou 20 de vida!";
      } else {
        mensagem = "⚠️ Você não tem ouro suficiente para comprar uma poção!";
      }
    });
  }

  void verificarEstadoDoJogo() {
    if (vida <= 0) {
      mensagem = "💀 Você foi derrotado! O dragão venceu...";
    } else if (xp >= 100 && enfrentandoChefe) {
      mensagem = "🏆 Parabéns! Você derrotou o dragão e venceu a aventura!";
      venceu = true;
    }
  }

  void reiniciarJogo() {
    setState(() {
      xp = 0;
      ouro = 0;
      vida = 100;
      enfrentandoChefe = false;
      venceu = false;
      mensagem = "🎲 Role o dado para iniciar sua aventura!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '💖 Vida: $vida  |  🏅 XP: $xp  |  💰 Ouro: $ouro',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          mensagem,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        Image.asset(
          venceu ? 'assets/trofeu.png' : 'assets/dados/dado_$resultadoDado.jpg',
          height: 100,
          width: 100,
        ),
        const SizedBox(height: 20),
        if (!venceu && vida > 0)
          ElevatedButton(
            onPressed: jogarDado,
            child: const Text('🎲 Jogar Dado'),
          ),
        if (!venceu && vida > 0)
          ElevatedButton(
            onPressed: usarPocao,
            child: const Text('🧪 Usar Poção (-10 Ouro)'),
          ),
        if (venceu || vida <= 0)
          ElevatedButton(
            onPressed: reiniciarJogo,
            child: const Text('🔄 Reiniciar Jogo'),
          ),
      ],
    );
  }
}
