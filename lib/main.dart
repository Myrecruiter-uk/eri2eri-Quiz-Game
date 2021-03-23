import 'package:flutter/material.dart';
import 'story_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Destini());

class Destini extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: StoryPage(),
    );
  }
}

class StoryPage extends StatefulWidget {
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  StoryBrain storyBrain;

  @override
  void initState() {
    super.initState();
    storyBrain = StoryBrain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Eri2Eri Quize Puzzle",
          style: TextStyle(color: Colors.black54),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Colors.amber,
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Story",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0, color: Colors.black)),
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    storyBrain.getStoryQuestion(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: FlatButton(
                  onPressed: () {
                    if (storyBrain.getCurrentIndex() ==
                        storyBrain.getArrayLength()) {
                      storyBrain.resetCounter();
                      setState(() {});
                    } else {
                      if (storyBrain.getAnswer()) {
                        showAlert("Great Job!", "You got the correct answer!",
                            context);
                      } else {
                        showAlert(
                            "Wrong Answer!", "You guessed wrong!", context);
                      }
                    }
                  },
                  color: Colors.black,
                  child: Text(
                    storyBrain.getChoice1(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, color: Colors.amber),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              storyBrain.getCurrentIndex() != storyBrain.getArrayLength()
                  ? Expanded(
                      flex: 2,
                      child: FlatButton(
                        onPressed: () {
                          if (!storyBrain.getAnswer()) {
                            showAlert("Great Job!",
                                "You got the correct answer!", context);
                          } else {
                            showAlert(
                                "Wrong Answer!", "You guessed wrong!", context);
                          }
                        },
                        color: Colors.black,
                        child: Text(
                          storyBrain.getChoice2(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    )
                  : Text(""),
            ],
          ),
        ),
      ),
    );
  }

  showAlert(String message, String description, BuildContext context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: message,
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            "Cool",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {});
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }
}
