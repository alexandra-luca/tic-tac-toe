import 'package:flutter/material.dart';

void main() {
  runApp(GameApp());
}

class GameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tic-tac-toe',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: GamePage(title: "tic-tac-toe"),
    );
  }
}

class GamePage extends StatefulWidget {
  GamePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<int> _state = [
    0, 0, 0, 0, 0, 0, 0, 0, 0,
  ];
  int _nextPlayer = 1;

  void _move(index) {
    setState(() {
      if (_state[index] == 0) {
        _state[index] = _nextPlayer;
        _nextPlayer = _nextPlayer == 1 ? 2 : 1;
      }
    });
  }

  void _reset() {
    setState(() {
      _state = [
        0, 0, 0, 0, 0, 0, 0, 0, 0,
      ];
      _nextPlayer = 1;
    });
  }

  void _check(index) {
    setState(() {
        if ((_state[0] == _state[1] && _state[1] == _state[2] && _state[1] != 0) ||
            (_state[3] == _state[4] && _state[4] == _state[5] && _state[4] != 0) ||
            (_state[6] == _state[7] && _state[7] == _state[8] && _state[7] != 0) ||
            (_state[0] == _state[3] && _state[3] == _state[6] && _state[3] != 0) ||
            (_state[1] == _state[4] && _state[4] == _state[7] && _state[4] != 0) ||
            (_state[2] == _state[5] && _state[5] == _state[8] && _state[5] != 0) ||
            (_state[0] == _state[4] && _state[4] == _state[8] && _state[4] != 0) ||
            (_state[2] == _state[4] && _state[4] == _state[6] && _state[4] != 0)) {
          _reset();
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                mainAxisExtent: 150,
            ),
            padding: const EdgeInsets.all(2.0),
            itemCount: 9,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {
                    _move(index);
                    _check(index);
                  },
                  child: Container(
                    color: _state[index] == 1 ? Colors.red : (_state[index] == 2 ? Colors.green : Colors.black26),
                  ),
              );
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.0),
            child: FlatButton(
              onPressed: () {
                _reset();
              },
              child: Text(
                'Play again!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
