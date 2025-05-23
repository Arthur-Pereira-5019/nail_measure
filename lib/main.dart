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
              top: 400,
              right: 200,
              child: SizedBox(
              width: 100,
              height: 40,
                child: TextField(
                  decoration: InputDecoration(
                  hintText: '2.5cm'
                )
              )
             )
             ),
        

          ],
        ),
      ),
    );
  }
}
