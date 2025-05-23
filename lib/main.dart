import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nail Measurer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Medidor de Unhas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var unhas = [0.0,0.0,0.0,0.0,0.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Color.fromRGBO(100, 100, 100, 100),
              ),
              height: 560,
              width: 600,
              child: Image(
                alignment: Alignment.bottomCenter,
                image: AssetImage((('resources/left_hand.png'))),
              ),
            ),

            Positioned(
              top: 175,
              left: 140,
              child: SizedBox(
                width: 60,
                height: 40,
                child: TextField(
                  onChanged: (text) {
                    unhas[0] = double.parse(text);
                    print(unhas[0]);
                  },
                  decoration: InputDecoration(hintText: '2.5cm'),
                ),
              ),
            ),

            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {

              },
              child: Text('Salvar unhas'),
            ),
          ],
        ),
      ),
    );
  }
}
