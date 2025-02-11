import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ValentineCardPage(),
    );
  }
}

class ValentineCardPage extends StatefulWidget {
  const ValentineCardPage({super.key});

  @override
  State<ValentineCardPage> createState() => _ValentineCardPageState();
}

class _ValentineCardPageState extends State<ValentineCardPage>
    with SingleTickerProviderStateMixin {
  double _yesButtonScale = 1.0;
  double _noButtonScale = 1.0;
  late AnimationController _controller;
  bool _showQuestion = false;
  bool _showCelebration = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showQuestion = true;
      });
    });
  }

  void _showCelebrationGif() {
    setState(() {
      _showCelebration = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.pink[100]!,
              Colors.pink[50]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_showCelebration)
                Image.asset(
                  '/Users/rishishah/Desktop/valentine/valentine_web/assets/vd.gif', // Heart animation GIF
                  height: 200,
                ),
              // if (_showCelebration)
              //   Image.asset(
              //     '/Users/rishishah/Desktop/valentine/valentine_web/assets/vd2.gif', // Celebration GIF
              //     height: 200,
              //   ),
              const SizedBox(height: 40),
              AnimatedOpacity(
                opacity: _showQuestion ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    Text(
                      'Will you be my Valentine?',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[800],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.scale(
                          scale: _yesButtonScale,
                          child: ElevatedButton(
                            onPressed: () {
                              _showCelebrationGif();
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('❤️ Yay! ❤️'),
                                  content: Image.asset("/Users/rishishah/Desktop/valentine/valentine_web/assets/vd2.gif",height: 200, width: 200,),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                            ),
                            child: const Text(
                              'Yes!',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Transform.scale(
                          scale: _noButtonScale,
                          child: ElevatedButton(
                            onPressed: () {
                              // Playfully prevent saying no by moving the button
                              _noButtonScale *= 0.8;
                              _yesButtonScale *= 1.2;
                              setState(() {
                                _controller.forward();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                            ),
                            child: const Text(
                              'No',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
