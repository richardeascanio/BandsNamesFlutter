import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_name_app/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 2),
    Band(id: '2', name: 'Queen', votes: 5),
    Band(id: '3', name: 'Bon Jovi', votes: 3),
    Band(id: '4', name: 'Kiss', votes: 4),
    Band(id: '5', name: 'AC/DC', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Band Names',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _bandTitle(bands[i])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTitle(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction');
        print('band id: ${band.id}');
        // TODO: llamar el borrado en el server
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete band', style: TextStyle(color: Colors.white))
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2).toUpperCase()),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = new TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New band name:'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text)
              )
            ],
          );
        }
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text('New band name'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      });
  }

  void addBandToList(String name) {
    print(name);

    if (name.length > 1) {
      // Podemos agregar
      this.bands.add(Band(id: '6', name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
