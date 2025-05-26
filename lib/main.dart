import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

  var unhas = ["0.0","0.0","0.0","0.0","0.0"];
 

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 0, 255)),
        scaffoldBackgroundColor: Theme.of(context).colorScheme.primary
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
      appBar: AppBar(title: Text(widget.title),backgroundColor: Theme.of(context).colorScheme.primary),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary
              ),
              height: 560,
              width: 600,
              child: Image(
                alignment: Alignment.bottomCenter,
                image: AssetImage((('resources/left_hand.png'))),
              ),
            ),

            InputNail(positionTop: 175, positionLeft: 140),
            InputNail(positionTop: 130, positionLeft: 220),
            InputNail(positionTop: 110, positionLeft: 295),
            InputNail(positionTop: 135, positionLeft: 355),
            InputNail(positionTop: 280, positionLeft: 400),

            saveNail()
          ],
        ),
      ),
    );
  }
}

class InputNail extends StatelessWidget {
  final double positionTop;
  final double positionLeft;


   const InputNail({
    Key? key,
    required this.positionTop,
    required this.positionLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
              top: positionTop,
              left: positionLeft,
              child: SizedBox(
                width: 60,
                height: 40,
                child: TextField(
                  onChanged: (text) {
                    unhas[0] = text;
                    print(unhas[0]);
                  },
                  decoration: InputDecoration(hintText: '2.5cm'),
                ),
              ),
            );
  }

}

class saveNail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {

              },
              child: Text('Salvar unhas'),
            );
    
  }

void registerNail() async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('tamanhoDasUnhas', unhas);
}

}

class NailRegister {
  final List<double> tamanhos;
  final DateTime data;
  final bool bonsHabitos;
  final int id;

  const NailRegister({required this.tamanhos, required this.data, required this.bonsHabitos, required this.id});
}
