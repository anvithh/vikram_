import 'package:flutter/material.dart';

import '../widgets/add_rules_personal.dart';
import '../widgets/header.dart';
import '../widgets/upload_button.dart';

class BothPage extends StatefulWidget {
  const BothPage({super.key});

  @override
  State<BothPage> createState() => _BothPageState();
}

class _BothPageState extends State<BothPage> {
  int _currentStep = 0;

  List<Step> _steps() => [
        Step(
          isActive: _currentStep >= 0,
          title: const Text(''),
          content: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                child: Text(
                  'Tell the bot about yourself',
                  style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: Colors.black),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "Your bot will speak about you to potential employers and customers. Give the best and authentic details about yourself.",
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black), // Add enabled border color
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black), // Add disabled border color
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.black)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    filled: false,
                    fillColor: const Color(0xFF161A27),
                    focusColor: Colors.black,
                    labelText: 'About yourself..',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintStyle: const TextStyle(color: Colors.black),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 40.0, horizontal: 16.0),
                  ),
                  maxLines: null, // Allow unlimited lines of text

                  textInputAction: TextInputAction
                      .done, // Change the keyboard action button to 'Done'
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0, 30, 0),
                child: Text(
                  "Or simply upload your resume and the bot will do the rest!",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  UploadButtonWidget(
                    content: "Upload Resume",
                    color: Color(0xFF161A27),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
        Step(
          title: const Text(''),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Set the Interaction Rules',
                style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text(
                  "Set rules which your bot needs to follow when others contact it!",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const Row(
                children: [
                  Text(
                    'Upload the rules: ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  UploadButtonWidget(
                    content: "Upload PDF document",
                    color: Color(0xFF161A27),
                    textColor: Colors.white,
                  ),
                ],
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 80,
                  ),
                  Text(
                    "or",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Add rules manually: ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  AddRulesPersonal(
                    color: Color(0xFF161A27),
                    iconColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Can’t figure out how to set the rules?\nHere's a sample:",
                        style:
                            TextStyle(color: Color(0xFF5F626A), fontSize: 13),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Interaction Rules Example',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: const SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'A vendor manager named John Doe working in XYZ company receives a lot of proposals on a daily basis all of which are difficult for him to go through. He can set the interaction rules as follows',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 30),
                                            Text(
                                              'Rule 1:\nIntroduce yourself as assistant of Jon Doe.',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Rule 2:\nRequest the sales representative to introduce themselves and the company which they come from.',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Rule 3:\nIf they are from ABC Company, politely decline the proposal stating that there is a freeze on doing business with ABC Company.',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Rule 4:\nIf they are from any other company, ask them to explain the proposal.',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Rule 5:\nThe unit price is beyond 100\$, politely decline the proposal.',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Rule 6:\nAsk them on the clients they serve.',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Rule 7:\nIf there are no fortune 500 clients then politely refuse.',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Rule 8:\nIf you have not refused so far, then respond to them that I will get back to them.',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          "See Example",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Sample Chat',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        RichText(
                                          text: const TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Bot: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Hello! I\'m the assistant of Amit Kumar!',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 13.0,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Initiator:',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          'Hello. I need your help to connect with Amit. I have a great proposal for his company.',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const Text(
                                          '.\n.\n.',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Close',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 180,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xFF161A27),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                        child: Text(
                          "Sample chat with these rules",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Default Rules',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: const SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20),
                                        Text(
                                          'Rule 1:\nVerify the identity of the person initiating contact. Confirm their name and organization',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'Rule 2:\nAsk the person to briefly state the purpose of the interaction or the problem they want to solve',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'Rule 3:\nTry responding to the problem to the best of your ability',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'Rule 4:\nPolitely decline the interaction appears negative, abusive or harmful.',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'Rule 5:\nAfter every interaction, ask for feedback',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 15),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Close',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 180,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xFF161A27),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                        child: Text(
                          "Skip and apply Default Rules",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          isActive: _currentStep >= 1,
        ),
        Step(
          isActive: _currentStep >= 2,
          title: const Text(''),
          content: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                child: Text(
                  'Add information about your business or company',
                  style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 30, 30, 0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black), // Add enabled border color
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black), // Add disabled border color
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    filled: false,
                    fillColor: const Color(0xFF161A27),
                    focusColor: Colors.black,
                    labelText: 'About the agent..',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintStyle: const TextStyle(color: Colors.black),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 40.0, horizontal: 16.0),
                  ),
                  maxLines: null, // Allow unlimited lines of text

                  textInputAction: TextInputAction
                      .done, // Change the keyboard action button to 'Done'
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0, 10, 0),
                child: Text(
                  "Or upload any document containing details of your business or company:",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  UploadButtonWidget(
                    content: "Upload Document",
                    color: Color(0xFF161A27),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30.0, 40, 10, 0),
                child: Text(
                  "Or give the link to your business linkedin page:",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 45,
                    width: 250,
                    child: Center(
                      child: TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'LinkedIn link',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          // Add any desired styling or customization for the text field
                        ),
                        // Add any necessary validation or controller properties
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Step(
          isActive: _currentStep >= 3,
          title: const Text(''),
          content: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Add Role Description',
                      style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                          color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'Role Description Example',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: const SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'You are a career counselor with 10 years of experience guiding students in India.\nYou are well-versed in helping students make informed decisions about their careers after 12th grade.',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        "See Example",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 30, 30, 0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black), // Add enabled border color
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black), // Add disabled border color
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.black)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    filled: false,
                    fillColor: const Color(0xFF161A27),
                    focusColor: Colors.white,
                    labelText: 'Role description..',
                    labelStyle: const TextStyle(color: Colors.grey),
                    hintStyle: const TextStyle(color: Colors.black),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 40.0, horizontal: 16.0),
                  ),
                  maxLines: null, // Allow unlimited lines of text

                  textInputAction: TextInputAction
                      .done, // Change the keyboard action button to 'Done'
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0, 30, 0),
                child: Text(
                  "Or upload resume to get a role description!",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(
                    Icons.cloud_upload,
                  ),
                   SizedBox(
                    width: 20,
                  ),
                  UploadButtonWidget(
                    content: "Upload Resume",
                    color: Color(0xFF161A27),
                    
                  ),
                ],
              ),
            ],
          ),
        ),
        Step(
          isActive: _currentStep >= 4,
          title: const Text(''),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Set the Agent Rules',
                style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Can’t figure out how to set the rules?\nHere's a sample:",
                        style:
                            TextStyle(color: Color(0xFF5F626A), fontSize: 13),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Agent Rules Example',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: const SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Step 1:',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Introduce yourself ',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Step 2:',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Ask questions to the user to guage his personality. Ask one question at a time and when user responds only then ask the next question.',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Step 3:',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '3.	Ask questions to gauge his career interests. Ask one question at a time and when user responds, only then ask the next question.',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Step 4:',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Based on the inputs from 2 and 3 deduce a suitable career path.',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Step 5:',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Browse the web to find the top 10 institutes for the career path',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Step 6:',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Browse the web to find jobs and average salaries for the roles',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Step 7:',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Respond with the career path the institutes and the average salaries.',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Step 8:',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Keep your response crisp and to the point.',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          "See Example",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const Row(
                children: [
                   Text(
                    'Add rules: ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                   SizedBox(
                    width: 5,
                  ),
                   AddRulesPersonal(color: Color(0xFF161A27), iconColor: Colors.white,),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Sample Chat',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        RichText(
                                          text: const TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Bot: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Hello! I\'m the assistant of Amit Kumar!',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 13.0,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Initiator:',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          'Hello. I need your help to connect with Amit. I have a great proposal for his company.',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const Text(
                                          '.\n.\n.',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Close',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 180,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xFF161A27),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                        child: Text(
                          "Sample chat with these rules",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HeaderWidget(),
          Expanded(
            child: Theme(
              data: ThemeData(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF161A27),
                ),
                canvasColor: Colors.white,
                // canvasColor: const Color(0xFF161A27),
              ),
              child: Stepper(
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextButton(
                          onPressed: details.onStepCancel,
                          child: const Text(
                            'Back',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: details.onStepContinue,
                          child: const Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                type: StepperType.horizontal,
                currentStep: _currentStep,
                steps: _steps(),
                onStepContinue: () {
                  if (_currentStep < (_steps().length - 1)) {
                    setState(() {
                      _currentStep += 1;
                    });
                  }
                },
                onStepCancel: () {
                  if (_currentStep == 0) {
                    return;
                  }

                  setState(() {
                    _currentStep -= 1;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
