import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:vikram/features/presentation/pages/login.dart';
import 'package:vikram/features/presentation/widgets/add_rules_personal.dart';
import 'package:vikram/features/presentation/widgets/header.dart';
import 'package:vikram/features/presentation/widgets/upload_button.dart';
import 'package:http/http.dart' as http;

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  String? firstPDF;
  String? secondPDF;

  _uploadFirstPDF() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        firstPDF = file.name;
      });
      // print(
      // "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      // print(selectedFilePath);
    }
  }

  _uploadSecondPDF() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        secondPDF = file.name;
      });
      // print(
      // "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      // print(selectedFilePath);
    }
  }

  List<TextEditingController> listController = [TextEditingController()];

  TextEditingController user_info = TextEditingController();

  Future<void> submitBotRules(String username, String type1, String type2,
      String info, List<TextEditingController> botRules) async {
    List<String> botRules_ = [];
    var url = Uri.parse("https://server.vikrambots.in/store-rules");

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://server.vikrambots.in/store-rules'),
    );

    request.fields['username'] = username;
    request.fields['typeOfFile'] = type1;
    request.fields['typeOfFile2'] = type2;

    for (var controller in botRules) {
      botRules_.add(controller.text);
    }
    request.fields['rules'] = botRules_.join(", \n");
    request.fields['user_info'] = info;

    print("the request:\n\n\n");
    print(request);
    var response = await request.send();
    print(response);

    if (response.statusCode == 200) {
      // Request successful
      print(
          "succes!!!!!!!!!!!!!!!!!!!!!!"); // Process the response data as needed
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
    }

    print(type1);
    print(botRules_);
  }

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  int ruleNo = 1;

  int _currentStep = 0;
  List<Step> _steps() => [
        Step(
          isActive: _currentStep >= 0,
          title: const Text(''),
          content: Form(
            key: _formKey1,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                  child: Text(
                    'Tell the bot about yourself',
                    style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "Your bot will speak about you to potential employers and customers. Give the best and authentic details about yourself.",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name cannot be empty!';
                      }
                      final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');
                      if (!nameRegExp.hasMatch(value)) {
                        return 'Please enter a valid full name (only letters)';
                      }
                      return null;
                    },
                    controller: user_info,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white), // Add enabled border color
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white), // Add disabled border color
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      filled: false,
                      fillColor: const Color(0xFF161A27),
                      focusColor: Colors.white,
                      labelText: 'About yourself..',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintStyle: const TextStyle(color: Colors.white),
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
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_upload,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    UploadButtonWidget(
                      content: "Upload Resume",
                      color: Colors.white,
                      textColor: Colors.black,
                      tonTap: _uploadFirstPDF,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      firstPDF ?? 'No file selected',
                      style: TextStyle(color: Colors.grey[500], fontSize: 10.5),
                    ),
                  ],
                ),
              ],
            ),
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
                    color: Colors.white),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text(
                  "Set rules which your bot needs to follow when others contact it!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Upload the rules: ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  UploadButtonWidget(
                    content: "Upload PDF document",
                    color: Colors.white,
                    textColor: Colors.black,
                    tonTap: _uploadSecondPDF,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    secondPDF ?? 'No file selected',
                    style: TextStyle(color: Colors.grey[500], fontSize: 10.5),
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
              Row(
                children: [
                  const Text(
                    'Add rules manually: ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        listController.add(TextEditingController());
                        ruleNo = ruleNo + 1;
                      });
                    },
                    child: const AddRulesPersonal(
                      color: Colors.white,
                      iconColor: Colors.black,
                    ),
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
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey2,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listController.length - 1,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 80,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      // color: const Color(0xFF141824),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Rule ${index + 1}:",
                                                style: const TextStyle(
                                                    color: Color(0xFF161A27),
                                                    fontFamily: 'Orbitron',
                                                    fontSize: 10.7,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Name cannot be empty!';
                                                    }
                                                    final RegExp nameRegExp =
                                                        RegExp(r'^[a-zA-Z ]+$');
                                                    if (!nameRegExp
                                                        .hasMatch(value)) {
                                                      return 'Please enter a valid full name (only letters)';
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                      listController[index],
                                                  autofocus: false,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Input Text Here",
                                                    hintStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 132, 140, 155),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                if (index >= 0)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        listController[index].clear();
                                        listController[index].dispose();
                                        listController.removeAt(index);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                      size: 28,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
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
                                                          fontSize: 11.0,
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
                                              fontSize: 11.0,
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "Sample chat with these rules",
                          style: TextStyle(
                              color: Colors.grey[700],
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "Skip and apply Default Rules",
                          style: TextStyle(
                              color: Colors.grey[700],
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
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF161A27),
      body: Column(
        children: [
          const HeaderWidget(),
          Expanded(
            child: Theme(
              data: ThemeData(
                colorScheme: const ColorScheme.light(primary: Colors.white),
                canvasColor: const Color(0xFF161A27),
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
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                        TextButton(
                          onPressed: details.onStepContinue,
                          child: const Text(
                            'Next',
                            style: TextStyle(color: Colors.white, fontSize: 17),
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
                  bool isValid = false;
                  switch (_currentStep) {
                    case 0:
                      isValid = _formKey1.currentState!.validate();
                      break;
                    case 1:
                      isValid = _formKey2.currentState!.validate();
                      break;
                    
                  }

                  if (_currentStep < (_steps().length - 1)) {
                    if (isValid) {
                      setState(() {
                        _currentStep += 1;
                      });
                    }
                  } else {
                    if (isValid) {
                      bool isAllFormsValid =
                          _formKey1.currentState!.validate() &&
                              _formKey2.currentState!.validate() ;

                      if (isAllFormsValid) {
                        submitBotRules("exampleex", "text", "text", 
                            user_info.text, listController);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }
                    }
                  }
                },
                // onStepContinue: () {
                //   if (_currentStep < (_steps().length - 1)) {
                //     setState(() {
                //       _currentStep += 1;
                //     });
                //   } else {
                //     if (_formKey2.currentState!.validate() &&
                //         _formKey1.currentState!.validate()) {
                //       submitBotRules("wsssh", "text", "text", user_info.text,
                //           listController);
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => LoginPage()),
                //       );
                //     }
                //   }
                // },
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
