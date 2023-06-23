import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../widgets/chat_loading.dart';
import 'chat_message.dart';

Color color1 = Color(0xFF252834);
Color color2 = Color(0xFF141824);

Color mixedColor = Color.fromARGB(
  (color1.alpha + color2.alpha) ~/ 2,
  (color1.red + color2.red) ~/ 2,
  (color1.green + color2.green) ~/ 2,
  (color1.blue + 1.2*color2.blue) ~/ 2,
);

class ChatInterface extends StatefulWidget {
  const ChatInterface({super.key});

  @override
  State<ChatInterface> createState() => _ChatInterfaceState();
}

class _ChatInterfaceState extends State<ChatInterface> {
  bool isTyping = false;

  String reply = "";
  String text = "";
  //API CALL
  Future<void> _tempChat() async {
    setState(() {
      text = _controller.text;
    });
    print("TEXT BEING SENT\n");
    print(text);
    // var url = Uri.parse("http://10.0.2.2:8080/general/PadmajaAmma/$text");
    var url =
        Uri.parse("https://server.vikrambots.in/general/PadmajaAmma/$text");

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(url, headers: headers);
    print(url);
    print("\n\n\n\n\n\\n");
    print(response.body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // final success = responseData['success'];
      reply = responseData['message'];
    }
    if(response.statusCode == 502) {
      reply = "Sorry for the inconvenience, but our servers are currently experiencing high traffic.\n\nPlease retry your request later!";
    }
  }

  //for day and night modes
  bool _iconBool = false;
  IconData _day = Icons.wb_sunny;
  IconData _night = Icons.shield_moon;

  //
  final TextEditingController _controller = TextEditingController();

  final List<ChatMessage> _messages = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //send the message
  //const Color(0xFF252834) : Colors.transparent,
  void _sendMessage() async {
    ChatMessage _message = ChatMessage(
      text: _controller.text,
      sender: "user",
      color: _iconBool ? Colors.black : Colors.white,
      // colorUser: _iconBool ? Colors.transparent : const Color(0xFF252834),
      colorDay: _iconBool ? Colors.transparent : mixedColor,
    );

    setState(() {
      _messages.insert(0, _message);
      isTyping = true;
    });

    await _tempChat();
    _controller.clear();
    ChatMessage _reply = ChatMessage(
        text: reply,
        sender: "Bot",
        color: _iconBool ? Colors.black : Colors.white,
        colorBot: _iconBool ? Colors.grey[300] : Colors.transparent);

    setState(() {
      isTyping = false;
      _messages.insert(0, _reply);
    });
  }

  Widget _buildTextComposer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          // color: _iconBool ? Colors.white : const Color(0xFF252834),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) => _sendMessage(),
                  style: TextStyle(
                    fontSize: 15,
                    color: _iconBool ? Colors.black : Colors.grey,
                  ),
                  decoration: InputDecoration.collapsed(
                      hintText: "Text Area",
                      hintStyle: TextStyle(
                        color: _iconBool ? Colors.black : Colors.grey,
                      )),
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.mic),
                  color: _iconBool ? Colors.black : Colors.grey,
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: _iconBool ? Colors.black : Colors.grey,
                  onPressed: () {
                    _tempChat();
                    _sendMessage();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color(0xFF141824),
        title: Row(
          children: [
            // Add your logo widget here
            Image.asset(
              'assets/logo2.jpg',
              height: 85,
              width: 85,
            ),
            const SizedBox(
              width: 8,
            ), // Add some spacing between the logo and drawer icon
          ],
        ),
        actions: [
          // Add the drawer icon as an action
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer(); // Open the end drawer
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Container(
          color:
              const Color(0xFF141824), // Set the background color of the drawer
          child: Column(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF141824),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      // Replace with user's profile image
                      child: Icon(
                        Icons.person_outline,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 16),
                    // Replace with user's name
                    Text(
                      'Full Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 0),
              const Divider(
                color: Colors.grey,
              ), // Vertical space
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Notifications',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Handle notification selection
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.history,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Your history',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Handle notification selection
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Your saved searches',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Handle notification selection
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person_2_outlined,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Mode',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Handle notification selection
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _iconBool = !_iconBool;
                        });
                      },
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {
                            setState(() {
                              _iconBool = !_iconBool;
                            });
                          },
                          icon: Icon(
                            _iconBool ? _day : _night,
                            color: Colors.white,
                          ),
                        ),
                        title: _iconBool
                            ? const Text(
                                'Day Mode',
                                style: TextStyle(color: Colors.white),
                              )
                            : const Text(
                                'Night Mode',
                                style: TextStyle(color: Colors.white),
                              ),
                        onTap: () {
                          setState(() {
                            _iconBool = !_iconBool;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person_2_outlined,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Updates and FAQ',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Handle notification selection
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
      //
      //
      body: Container(
        decoration: BoxDecoration(
            color: _iconBool ? Colors.white : const Color(0xFF161A27)),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset(
                "assets/chat-screen-top-left.svg",
                fit: BoxFit.contain,
                width: 170,
                height: 170,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset(
                "assets/chat-screen-top-right.svg",
                fit: BoxFit.contain,
                width: 10,
                height: 10,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SvgPicture.asset(
                "assets/chat-screen-bottom-left.svg",
                fit: BoxFit.none,
                width: 0,
                height: 120,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(
                "assets/chat-screen-bottom-right.svg",
                fit: BoxFit.contain,
                width: 400,
                height: 400,
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Flexible(
                    // fit: FlexFit.loose,
                    child: ListView.builder(
                      // shrinkWrap: true,
                      reverse: true,
                      padding: const EdgeInsets.all(0),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return _messages[index];
                      },
                    ),
                  ),
                  if (isTyping) const ThreeDots(),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: SizedBox(
                      height: 150,
                      // decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 5),
                                  Center(
                                      child: Text(
                                    "Reset chat",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                                ],
                              ),
                            ),
                          ),
                          _buildTextComposer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
