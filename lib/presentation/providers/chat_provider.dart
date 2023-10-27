import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_or_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

//Puede notificar cuando hay cambios
class ChatProvider extends ChangeNotifier {
  //Hacer que la pantalla scrollee hacia abajo a medida que se inserten mensajes
  final ScrollController chatScrollController = ScrollController();

  final getYesOrNoAnswer = GetYesOrNoAnswer();

  List<Message> messageList = [
    Message(text: 'si' , fromWho: FromWho.me),
    Message(text: 'no', fromWho: FromWho.me),
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);
    if(text.endsWith('?')){
      await herReply();
    }
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> herReply() async {
    final herMessage = await getYesOrNoAnswer.getAnswer();
    messageList.add(herMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  void moveScrollToBottom() async{
    //espera 100 milisegundos para ejecutar el codigo de scroll
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate);
  }
}