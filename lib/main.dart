import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter_greedygame_plugin/flutter_greedygame_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

const String FloatUnit = "float-4048";
const String NativeUnit = "unit-4258";

class _MyAppState extends State<MyApp> {
  // GreedyGame Ad local path will be updated in this path
  String floatPath = "";
  String nativePath = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _setFloatPath(String path) {
      setState(() {
        floatPath = path;
      });
    }

    void _setNativePath(String path) {
      setState(() {
        nativePath = path;
      });
    }

    Widget _createFloatWidget() {
      if (floatPath != null && floatPath.isNotEmpty) {
        var widget = GestureDetector( // Setting Click listener to notify GreedyGame that the user has clicked on the Ad.
            onTap: () {
              GreedyGame.instance.showUii(FloatUnit);
            },
            child: Image.file(File(floatPath)));
        return widget;
      }
      // This is just a placeholder image when ad is not available;
      return SizedBox(
        child: Image.asset("assets/image1.jpg"),
        width: 200.0,
        height: 200.0,
      );
    }

    Widget _createNativeWidget() {
      if (nativePath != null && nativePath.isNotEmpty) {
        return Image.file(File(floatPath));
      }
      // This is just a placeholder image when ad is not available;
      return SizedBox(
        child: Image.asset("assets/image2.jpg"),
        width: 200.0,
        height: 200.0,
      );
    }

    void campaignAvailable() {
      GreedyGame.instance.getPath(FloatUnit).then(_setFloatPath);
      GreedyGame.instance.getPath(NativeUnit).then(_setNativePath);
    }

    void campaignUnAvailable() {
      // Resetting the native unit when the ad is not available
      _setFloatPath("");
      _setNativePath("");
    }

    void campaignError() {
      // Resetting the native unit when the ad is not available
      _setFloatPath("");
      _setNativePath("");
    }

    void initializeGreedyGame() {
      var units = <String>{"float-4048", "unit-4258"};

      GreedyGame.instance
          .setGameID("22800266") // Game id
          .setUnits(units.toList())
          .setAdmobEnabled(true)
          .setCampaignAvailable(campaignAvailable)
          .setCampaignUnAvailable(campaignUnAvailable)
          .setCampaignError(campaignError)
          .init();
    }

    void refreshAd() {
      GreedyGame.instance.refresh();
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GreedyGame Example app'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: initializeGreedyGame,
                          child: Text("Init"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: refreshAd,
                          child: Text("Refresh Ad"),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    FloatUnit + " Clickable",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _createFloatWidget(),
                  SizedBox(height: 20.0),
                  Text(
                    NativeUnit + " Non Clickable",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _createNativeWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
