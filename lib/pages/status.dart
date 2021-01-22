import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:band_name_app/providers/socket_service.dart';

class StatusPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Server status: ${ socketService.serverStatus }')
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          socketService.socket.emit('emitir-mensaje', {
            'nombre': 'Flutter',
            'mensaje': 'Hola desde flutter'
          });
          print('Presionado el fab');
        },
        child: Icon(Icons.message),
      ),
    );
  }
}