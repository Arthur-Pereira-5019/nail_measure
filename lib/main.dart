import 'dart:io';

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
double platformOffset = 0;
NailDatabase db = NailDatabase();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(!Platform.isAndroid) {
      databaseFactory = databaseFactoryFfi;
  }else {
    platformOffset = 580;
    print("Tá no android mermo");
  }
  await db.createDatabase();
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
          seedColor: const Color.fromARGB(255, 106, 0, 109),
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
          seedColor: const Color.fromARGB(255, 255, 132, 189),
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
            NailTable()
          ],
        ),
      ),
    );
  }
}

class NailTable extends StatefulWidget  {

  const NailTable({
    super.key,
  });

  @override
   _NailTable createState() => _NailTable();
}

class _NailTable extends State<NailTable> {
  List<Nail> nails = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadNails();
  }

  Future<void> loadNails() async {
      final a = await db.nailMaps();
      nails = a.map((m) => Nail.fromMap(m)).toList();
    
    
    setState((){
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Data')),
          DataColumn(label: Text('Min. Esq.')),
          DataColumn(label: Text('Ane. Esq.')),
          DataColumn(label: Text('Mei. Esq.')),
          DataColumn(label: Text('Ind. Esq.')),
          DataColumn(label: Text('Pol. Esq.')),
          DataColumn(label: Text('Min. Dir.')),
          DataColumn(label: Text('Ane. Dir.')),
          DataColumn(label: Text('Mei. Dir.')),
          DataColumn(label: Text('Ind. Dir.')),
          DataColumn(label: Text('Pol. Dir.')),
        ],
        rows: nails.map((nail) {
          return DataRow(cells: [
            DataCell(Text(nail.data.toString())),
            DataCell(Text(nail.tMiEs.toString())),
            DataCell(Text(nail.tAnEs.toString())),
            DataCell(Text(nail.tMeEs.toString())),
            DataCell(Text(nail.tInEs.toString())),
            DataCell(Text(nail.tPoEs.toString())),
            DataCell(Text(nail.tMiDi.toString())),
            DataCell(Text(nail.tAnDi.toString())),
            DataCell(Text(nail.tMeDi.toString())),
            DataCell(Text(nail.tInDi.toString())),
            DataCell(Text(nail.tPoDi.toString())),
          ]);
        }).toList(),
      ),
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
          InputNail(positionTop: 175, positionLeft: 620-platformOffset, key: Key("a")),
          InputNail(positionTop: 130, positionLeft: 680-platformOffset, key: Key("b")),
          InputNail(positionTop: 110, positionLeft: 770-platformOffset, key: Key("c")),
          InputNail(positionTop: 135, positionLeft: 815-platformOffset, key: Key("d")),
          InputNail(positionTop: 280, positionLeft: 870-platformOffset, key: Key("e")),
        } else if (type == 2) ...{
          Container(height: 560, width: 600, alignment: Alignment.bottomLeft, child: SaveNail()),
          Container(height: 560, width: 600, alignment: Alignment.bottomRight, child: SeeRegisters()),
          InputNail(positionTop: 175, positionLeft: 620-platformOffset, key: Key("f")),
          InputNail(positionTop: 130, positionLeft: 680-platformOffset, key: Key("g")),
          InputNail(positionTop: 110, positionLeft: 770-platformOffset, key: Key("h")),
          InputNail(positionTop: 135, positionLeft: 815-platformOffset, key: Key("i")),
          InputNail(positionTop: 280, positionLeft: 870-platformOffset, key: Key("j")),
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
          style: TextStyle(color: Color.fromARGB(255, 0, 145, 255)),
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
          decoration: InputDecoration(hintText: '2.5cm', hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)))
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

class SeeRegisters extends StatelessWidget {
  const SeeRegisters({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'registers',
      onPressed: () {
        Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const NailTablePage(title: "Registros")),
);
      },
      shape: const CircleBorder(),
      child: Icon(Icons.menu),
    );
  }
}

void registerNail() async {
    db.registerNail(
    new Nail(
      id: await db.autoIncrement(),
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