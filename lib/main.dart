import 'package:flutter/material.dart';

void main() => runApp(AlcoholControlApp());

class AlcoholControlApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '喝酒要科学',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.brown,
      ),
      home: AlcoholControlHomePage(title: '喝酒要科学', key: Key('homepage')),
    );
  }
}

enum DrinkFreq {
  daily,
  occational,
}

enum AlcoholType {
  YellowRiseWine,
  Beer,
  Wine,
  WhiteSpirit56,
  WhiteSpirit53,
  WhiteSpirit50,
  WhiteSpirit48,
  WhiteSpirit40,
  WhiteSpirit38,
  WhiteSpirit35,
  WhiteSpirit28,
}

String getAlcoholName(AlcoholType at) {
  switch(at) {
    case AlcoholType.YellowRiseWine: {
      return "黄酒";
    }
    case AlcoholType.Beer: {
      return "啤酒";
    }
    case AlcoholType.Wine: {
      return "葡萄酒";
    }
    case AlcoholType.WhiteSpirit28: {
      return "白酒 28°";
    }
    case AlcoholType.WhiteSpirit35: {
      return "白酒 35°";
    }
    case AlcoholType.WhiteSpirit38: {
      return "白酒 38°";
    }
    case AlcoholType.WhiteSpirit40: {
      return "白酒 40°";
    }
    case AlcoholType.WhiteSpirit48: {
      return "白酒 48°";
    }
    case AlcoholType.WhiteSpirit50: {
      return "白酒 50°";
    }
    case AlcoholType.WhiteSpirit53: {
      return "白酒 53°";
    }
    case AlcoholType.WhiteSpirit56: {
      return "白酒 56°";
    }
  }
  return "";
}

double getAlcoholDeg(AlcoholType at) {
  switch(at) {
    case AlcoholType.YellowRiseWine: {
      return 0.20;
    }
    case AlcoholType.Beer: {
      return 0.12;
    }
    case AlcoholType.Wine: {
      return 0.18;
    }
    case AlcoholType.WhiteSpirit28: {
      return 0.28;
    }
    case AlcoholType.WhiteSpirit35: {
      return 0.35;
    }
    case AlcoholType.WhiteSpirit38: {
      return 0.38;
    }
    case AlcoholType.WhiteSpirit40: {
      return 0.40;
    }
    case AlcoholType.WhiteSpirit48: {
      return 0.48;
    }
    case AlcoholType.WhiteSpirit50: {
      return 0.50;
    }
    case AlcoholType.WhiteSpirit53: {
      return 0.53;
    }
    case AlcoholType.WhiteSpirit56: {
      return 0.56;
    }
  }
  return 0;
}

// Get the max drink limit of liquid in mili-litre 
double getDrinkLimit(double alcoholAmount, double deg) {
  return alcoholAmount / deg * 1.25;
}

String formatOutput(double drinkLimit) {
  int jin = (drinkLimit / 500).floor();
  int liang = ((drinkLimit - 500 * jin) / 50).floor();

  String outstr = "";

  if (drinkLimit >= 25 && drinkLimit < 50) {
    return "半两";
  } else if (drinkLimit < 25) {
    return "一丢丢";
  }

  if (jin > 0) {
    outstr += jin.toString() + " 斤 ";
  }
  if (liang > 0) {
    outstr += liang.toString() + " 两";
  }
  return outstr;
}

class AlcoholControlHomePage extends StatefulWidget {
  AlcoholControlHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _AlcoholControlHomePageState createState() => _AlcoholControlHomePageState();
}

class _AlcoholControlHomePageState extends State<AlcoholControlHomePage> {
  // Limit of grams of alcohol per day
  final double _dailyVolume = 40.0;
  final double _occationalVolume = 80.0;

  DrinkFreq _freq = DrinkFreq.daily;
  AlcoholType _typ = AlcoholType.YellowRiseWine;

  void _switchFreq(freq) {
    setState(() {
      _freq = freq;
    });
  }

  void _switchTyp(typ) {
    setState(() {
      _typ = typ;
    });
  }

  Widget _buildTypeBtn(AlcoholType at) {
    return RaisedButton(
      child: Text(getAlcoholName(at), style: TextStyle(fontSize: 20, color: Color(0xFFEEE8D5))),
      onPressed: _typ == at ? null : () => _switchTyp(at),
      disabledColor: Colors.green,
      color: Colors.grey,
    );
  }

  Widget _buildOutputRow(String description, double drinkLimit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Text(description, style: TextStyle(fontSize: 24)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text(
              formatOutput(drinkLimit),
              style: TextStyle(fontSize: 30, color: Colors.brown),
            ),
            Text(
              "(" + drinkLimit.round().toString() + " ml)",
              style: TextStyle(fontSize: 28, color: Colors.brown),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    double drinkLimit = getDrinkLimit(
      _freq == DrinkFreq.daily ? _dailyVolume : _occationalVolume,
      getAlcoholDeg(_typ)
    );

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the AlcoholControlHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Drink Frequency
            Text(
              '饮酒频率',
              style: TextStyle(fontSize: 28),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget> [
                RaisedButton(
                  child: Text('每天喝', style: TextStyle(fontSize: 20, color: Color(0xFFEEE8D5))),
                  onPressed: _freq == DrinkFreq.daily ? null : () => _switchFreq(DrinkFreq.daily),
                  disabledColor: Colors.green,
                  color: Colors.grey,
                ),
                RaisedButton(
                  child: Text('聚会喝', style: TextStyle(fontSize: 20, color: Color(0xFFEEE8D5))),
                  onPressed: _freq == DrinkFreq.occational
                    ? null
                    : () => _switchFreq(DrinkFreq.occational),
                  disabledColor: Colors.green,
                  color: Colors.grey,
                ),
              ]
            ),

            // Alcohol Type
            Text(
              '饮酒种类',
              style: TextStyle(fontSize: 28),
            ),
            Wrap(
              spacing: 1.0,
              alignment: WrapAlignment.spaceBetween,
              children: <Widget> [
                _buildTypeBtn(AlcoholType.YellowRiseWine),
                _buildTypeBtn(AlcoholType.Beer),
                _buildTypeBtn(AlcoholType.Wine),
                _buildTypeBtn(AlcoholType.WhiteSpirit28),
                _buildTypeBtn(AlcoholType.WhiteSpirit35),
                _buildTypeBtn(AlcoholType.WhiteSpirit38),
                _buildTypeBtn(AlcoholType.WhiteSpirit40),
                _buildTypeBtn(AlcoholType.WhiteSpirit48),
                _buildTypeBtn(AlcoholType.WhiteSpirit50),
                _buildTypeBtn(AlcoholType.WhiteSpirit53),
                _buildTypeBtn(AlcoholType.WhiteSpirit56),
              ],
            ),

            // Outputs
            Expanded(
              child: _buildOutputRow("今天最多饮酒 ", drinkLimit),
            ),
            Expanded(
              child: _buildOutputRow("每顿最多饮酒 ", drinkLimit / 2),
            ),
          ],
        ),
      ),
    );
  }
}
