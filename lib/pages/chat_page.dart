import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:titan_chat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = new FocusNode();
  bool _isWriting = false;

  List<ChatMessage> _message = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            CircleAvatar(
              child: Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue[100],
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Jhordan Restrepo',
              style: TextStyle(color: Colors.black87),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _message.length,
                itemBuilder: (_, i) => _message[i],
                reverse: true,
              )
            ),

            Divider(
              height: 1,
            ),

            //TODO: Caja de texto
            Container(
              margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(50),
              ),
              height: 45,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (text) {
              //TODO: cuando hay un valor para poder postear, cambia el color del boton
              setState(() {
                if (text.trim().length > 0) {
                  _isWriting = true;
                } else {
                  _isWriting = false;
                }
              });
            },
            decoration: InputDecoration.collapsed(hintText: 'Message'),
            focusNode: _focusNode,
          )),

          //Boton de enviar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(
                  child: Text('Enviar'), 
                  onPressed: _isWriting
                    ? () => _handleSubmit(_textController.text.trim())
                    : null,
                )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.send),
                        onPressed: _isWriting
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                      ),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  //Función que me permite obtener el valor de la caja de texto enviada
  _handleSubmit(String text) {

    if(text.length == 0) return;
    print(text);
    //Para limpiar la caja de texto despues de envia el mensaje
    _textController.clear();
    //Para mantener la caja abierta despues de enviar simplemente coloco esto:
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      text: text, 
      uid: '123',
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),
    );
    _message.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });
  }

  //Limpio varias cosas de la app al salirme de la pantalla de chat
  @override
  void dispose() {
    // TODO: Limpiar el Off del socket

    //Limpiar cada una de las instancias de nuestro array de message
    //Esto para evitar el uso innecesario de memoria en el dispositivo
    for( ChatMessage message in _message){
      message.animationController.dispose();
    }

    super.dispose();
  }
}
