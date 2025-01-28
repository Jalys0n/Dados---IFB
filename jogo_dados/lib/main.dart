import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(JogoDeDadosApp());
}

class JogoDeDadosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo de Dados',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jogo de Dados')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo ao Jogo de Dados!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaJogo()),
                );
              },
              child: Text('Jogar Dados'),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaJogo extends StatefulWidget {
  @override
  _TelaJogoState createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  int dado1 = 1;
  int dado2 = 1;

  void lancarDados() {
    setState(() {
      dado1 = Random().nextInt(6) + 1; // Gera um número entre 1 e 6
      dado2 = Random().nextInt(6) + 1; // Gera um número entre 1 e 6
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jogo de Dados')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/dado_$dado1.jpg', width: 100, height: 100),
                Image.asset('assets/dado_$dado2.jpg', width: 100, height: 100),

              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: lancarDados,
              child: Text('Lançar Dados'),
            ),
            SizedBox(height: 20),
            Text(
              'Resultado: ${dado1 + dado2}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
