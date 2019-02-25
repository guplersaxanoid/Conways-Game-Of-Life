
import 'package:cellular_automata/cellular_automata.dart';
import 'package:cellular_automata/rules.dart';
import 'package:flutter/material.dart';
import 'package:cgol_test2/gridRenderer.dart';

// Simple example of cellular_automata.
// For prettier outputs see the platform specific renderers
// Run in terminal with command: pub run example/game_of_life.dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}
CellGrid ss;
int gen;

class HomePageState extends State<HomePage>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final width = 100;
    final height = 100;
    final palette = new Map<GameOfLifeStates, String>.from({
      GameOfLifeStates.dead: ' ',
      GameOfLifeStates.deadUnderPopulated: ' ',
      GameOfLifeStates.deadOverPopulated: ' ',
      GameOfLifeStates.alive: '*',
      GameOfLifeStates.aliveBorn: '*',
    });

    final scene = new Scene<String>(
      width: width,
      height: height,
      fpsTarget: 10,
    );

    scene
      ..onPrepare.listen((int count) {
        scene
          ..clearAutomata()
          ..addAutomaton(
              automaton: new Automaton<GameOfLifeStates, String>(
                width: width,
                height: height,
                defaultState: GameOfLifeStates.dead,
                palette: palette,
                wrap: true,
                rules: new GameOfLife(),
              )..applyGenerator(new MathematicalGenerator<GameOfLifeStates>(
                  type: MathematicalGenerators.random,
                  valueTrue: GameOfLifeStates.aliveBorn,
                  valueFalse: GameOfLifeStates.dead)));
      })
      ..onFullPaint.listen((CellGrid<String> snapshot) {
        print('');
        print('Rules: Conway\'s Game of Life');
        print('Generation: ${scene.generationCounter}');
        print('');

        setState(() {
          ss = snapshot;
          gen = scene.generationCounter;
        });

      })
      ..onComplete.listen((SceneCompleteReason s) {
        scene.stop();
        print('All done! Stable scene detected.');
      })
      ..start();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[

            Container(
              child: CustomPaint(
                foregroundPainter: GridPainter(
                  snapshot: ss,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(color: Colors.black),
                ),
              ),
            ),
            Container(
                height: 50.0,
                child: Column(
                  children: <Widget>[
                    Text("Init State: random", style: TextStyle(color: Colors.white,fontSize: 20.0),),
                    Text("generation: $gen",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}