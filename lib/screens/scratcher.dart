import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';

class KaziKazan extends StatefulWidget {
  @override
  KaziKazanState createState() => KaziKazanState();
}

class KaziKazanState extends State<KaziKazan> {
  ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new ConfettiController(
      duration: new Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey,
      body: Center(
        child: Container(
          height: 200,
          width: 300,
          child: Center(
            child: Scratcher(
              brushSize: 15,
              threshold: 40,
              accuracy: ScratchAccuracy.low,
              image: Image.asset('images/scratch.png'),
              onThreshold: () => _controller.play(),
              child: Center(
                child: Column(
                  children: [
                    Container(
                        height: 150,
                        width: 200,
                        child: Center(
                          child: Text(
                            "Tebrikler 100 puan kazandınız",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30, color: Colors.blue),
                          ),
                        )),
                    ConfettiWidget(
                      blastDirectionality: BlastDirectionality.explosive,
                      confettiController: _controller,
                      particleDrag: 0.05,
                      emissionFrequency: 0.05,
                      numberOfParticles: 100,
                      gravity: 0.05,
                      shouldLoop: false,
                      colors: [
                        Colors.green,
                        Colors.red,
                        Colors.yellow,
                        Colors.blue,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/* Column(
                  children: [
                    ConfettiWidget(
                      blastDirectionality: BlastDirectionality.explosive,
                      confettiController: _controller,
                      particleDrag: 0.05,
                      emissionFrequency: 0.05,
                      numberOfParticles: 100,
                      gravity: 0.05,
                      shouldLoop: false,
                      colors: [
                        Colors.green,
                        Colors.red,
                        Colors.yellow,
                        Colors.blue,
                      ],
                    ),
                  ],
                ),   */
