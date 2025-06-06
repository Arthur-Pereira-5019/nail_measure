import 'package:flutter/material.dart';
import 'package:nail_measure/nailRegister.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


double a = 0;
double b = 0;
double c = 0;
double d = 0;
double e = 0;
double f = 0;
double g = 0;
double h = 0;
double i = 0;
double j = 0;
NailDatabase db = NailDatabase();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  db.createDatabase;
  databaseFactory = databaseFactoryFfi;
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
          child: ListView(
            children: [DisplayUnha(type: 1), DisplayUnha(type: 2)],
          ),
      ),
    );
  }
}

class SaveNail extends StatelessWidget {
  const SaveNail({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        registerNail();
      },
      child: Icon(Icons.save),
      shape: const CircleBorder(),
    );
  }
}

void registerNail() async {
    print(await getDatabasesPath());
  db.registerNail(
    new Nail(
      id: db.autoIncrement(),
      data: DateTime.now(),
      tMiEs: a,
      tAnEs: b,
      tMeEs: c,
      tInEs: d,
      tPoEs: e,
      tPoDi: f,
      tInDi: g,
      tMeDi: h,
      tAnDi: i,
      tMiDi: j,
    ),
  );
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
  final int type;
  const DisplayUnha({super.key, required this.type});

  //TODO: BORDA

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
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

        if (type == 1) ...{
          InputNail(positionTop: 175, positionLeft: 620, key: Key("a")),
          InputNail(positionTop: 130, positionLeft: 680, key: Key("b")),
          InputNail(positionTop: 110, positionLeft: 770, key: Key("c")),
          InputNail(positionTop: 135, positionLeft: 815, key: Key("d")),
          InputNail(positionTop: 280, positionLeft: 870, key: Key("e")),
        } else if (type == 2) ...{
          Align(alignment: Alignment.bottomCenter, child: SaveNail()),
          InputNail(positionTop: 175, positionLeft: 620, key: Key("f")),
          InputNail(positionTop: 130, positionLeft: 680, key: Key("g")),
          InputNail(positionTop: 110, positionLeft: 770, key: Key("h")),
          InputNail(positionTop: 135, positionLeft: 815, key: Key("i")),
          InputNail(positionTop: 280, positionLeft: 870, key: Key("j")),
        },
      ],
    );
  }
}

class InputNail extends StatelessWidget {
  final double positionTop;
  final double positionLeft;

  const InputNail({
    super.key,
    required this.positionTop,
    required this.positionLeft,
  });

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
            double temp;
            try {
              temp = double.parse(text);
            } catch (e) {
              temp = 0;
            }
            switch (key.toString().substring(3,4)) {
              case "a":
              a = temp;
              break;
              case "b":
              b = temp;
              break;
              case "c":
              c = temp;
              break;
              case "d":
              d = temp;
              break;
              case "e":
              e = temp;
              break;
              case "f":
              f = temp;
              break;
              case "g":
              g = temp;
              break;
              case "h":
              h = temp;
              break;
              case "i":
              i = temp;
              break;
              case "j":
              j = temp;
              break;
            }
          },
          decoration: InputDecoration(hintText: '2.5cm'),
        ),
      ),
    );
  }
}
