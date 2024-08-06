import 'package:chatapp/constants.dart';
import 'package:chatapp/providers/authentication_provider.dart';
import 'package:chatapp/widgets/button_chat_field.dart';
import 'package:chatapp/widgets/chat_app_bar.dart';
import 'package:chatapp/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    // current user uid
    final uid = context.read<AuthenticationProvider>().userModel!.uid;
    // get arguments passed frrom previous screen
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    // get the contactUID from the arguments
    final contactUID = arguments[Constants.contactUID];
    // get the contactName from the arguments
    final contactName = arguments[Constants.contactName];
    // get the contactImage from the arguments
    final contactImage = arguments[Constants.contactImage];
    // get the groupId from the arguments
    final groupId = arguments[Constants.groupId];
    // check if the groupId is empty
    final isGroupChat = groupId.isNotEmpty ? true : false;

    return Scaffold(
      appBar: AppBar(
        title: ChatAppBar(
          contactUID: contactUID,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: ChatList(contactUID: contactUID, groupId: groupId)),
            ButtonChatField(
              contactUID: contactUID,
              contactName: contactName,
              contactImage: contactImage,
              groupId: groupId,
            ),
          ],
        ),
      ),
    );
  }
}
