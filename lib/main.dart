import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var unhas = ["0.0", "0.0", "0.0", "0.0", "0.0"];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nail Measurer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 183, 0, 255),
        ),
        scaffoldBackgroundColor: Theme.of(context).colorScheme.primary,
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
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Scrollbar(
          child: ListView(children: [DisplayUnha(), DisplayUnha(), SaveNail()]),
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

class SaveNail extends StatelessWidget {
  const SaveNail({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Tela2()),
        );
      },
      child: Text('Salvar unhas'),
    );
  }
}

void registerNail() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('tamanhoDasUnhas', unhas);
}

class Tela2 extends StatelessWidget {
  const Tela2({
    super.key,
    //required this.positionTop,
    //required this.positionLeft,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dados das Unhas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 131, 32, 79),
        ),
        scaffoldBackgroundColor: Theme.of(context).colorScheme.primary,
      ),
      home: const NailTablePage(title: 'Medidor de Unhas'),
    );
  }
}

class NailTablePage extends StatefulWidget {
  const NailTablePage({super.key, required this.title});

  final String title;

  @override
  State<NailTablePage> createState() => _NailTablePage();
}

class _NailTablePage extends State<NailTablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              height: 560,
              width: 600,
              child: Opacity(
                opacity: 0.3,
                child: Image(
                  alignment: Alignment.bottomCenter,
                  image: AssetImage((('resources/left_hand.png'))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NailTable extends StatelessWidget {
  //final double positionTop;
  //final double positionLeft;

  const NailTable({
    super.key,
    //required this.positionTop,
    //required this.positionLeft,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text('Name', style: TextStyle(fontStyle: FontStyle.italic)),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text('Age', style: TextStyle(fontStyle: FontStyle.italic)),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text('Role', style: TextStyle(fontStyle: FontStyle.italic)),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine')),
            DataCell(Text('43')),
            DataCell(Text('Professor')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('William')),
            DataCell(Text('27')),
            DataCell(Text('Associate Professor')),
          ],
        ),
      ],
    );
  }
}

class DisplayUnha extends StatelessWidget {
  const DisplayUnha({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
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
      ],
    );
  }
}
