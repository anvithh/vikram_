import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:vikram/features/presentation/widgets/add_rules_personal.dart';
import 'package:vikram/features/presentation/widgets/text_field.dart';
import 'package:http/http.dart' as http;

import '../widgets/header.dart';
import '../widgets/upload_button.dart';
import 'login.dart';

class AgentPage extends StatefulWidget {
  const AgentPage({super.key});

  @override
  State<AgentPage> createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
  String? firstPDF;
  String? secondPDF;
  String? thirdPDF;
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

  _uploadThirdPDF() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        thirdPDF = file.name;
      });
      // print(
      // "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      // print(selectedFilePath);
    }
  }

  Future<void> submitBotRules(
      String username,
      String type1,
      String type2,
      String type3,
      String botRole,
      String companyInfo,
      List<TextEditingController> botRules) async {
    List<String> botRules_ = [];
    var url = Uri.parse("https://server.vikrambots.in/store-role-steps-info");

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://server.vikrambots.in/store-role-steps-info'),
    );

    request.fields['username_b'] = username;
    request.fields['typeOfFile'] = type1;
    request.fields['typeOfFile2'] = type2;
    request.fields['typeOfFile3'] = type3;
    request.fields['botrole'] = botRole;

    for (var controller in botRules) {
      botRules_.add(controller.text);
    }
    request.fields['steps'] = botRules_.join(", \n");
    request.fields['company_info'] = companyInfo;

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

  TextEditingController botRole = TextEditingController();
  TextEditingController companyInfo = TextEditingController();
  List<TextEditingController> listController = [TextEditingController()];
  int ruleNo = 1;

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();

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
                    validator: (value) {
                      // Regular expression to match only letters and numbers
                      final RegExp regExp = RegExp(r'^[a-zA-Z0-9\s]+$');

                      // Check if the paragraph contains only letters and numbers
                      if (!regExp.hasMatch(value!)) {
                        return 'It can contain only letters and numbers';
                      }
                      return null;
                    },
                    controller: companyInfo,
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
                      tonTap: _uploadFirstPDF,
                      content: "Upload Document",
                      color: const Color(0xFF161A27),
                      textColor: Colors.white,
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
        ),
        Step(
          isActive: _currentStep >= 1,
          title: const Text(''),
          content: Form(
            key: _formKey2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Add Role Description',
                            style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Role Description Example',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 30, 30, 0),
                  child: TextFormField(
                    validator: (value) {
                      final RegExp regExp = RegExp(r'^[a-zA-Z0-9\s]+$');

                      // Check if the paragraph contains only letters and numbers
                      if (!regExp.hasMatch(value!)) {
                        return 'It can contain only letters and numbers';
                      }
                      return null;
                    },
                    controller: botRole,
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
                      tonTap: _uploadSecondPDF,
                      content: "Upload Resume",
                      color: const Color(0xFF161A27),
                      textColor: Colors.white,
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
                      secondPDF ?? 'No file selected',
                      style: TextStyle(color: Colors.grey[500], fontSize: 10.5),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Step(
          isActive: _currentStep >= 2,
          title: const Text(''),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
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
              Row(
                children: [
                  const Text(
                    'Add rules: ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
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
                      color: Color(0xFF161A27),
                      iconColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey3,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listController.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 180,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF141824),
                                      // color: Colors.white,
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
                                                    color: Colors.white,
                                                    fontFamily: 'Orbitron',
                                                    fontSize: 11,
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
                                          const Row(
                                            children: [
                                              Text(
                                                'Upload knowledge base: ',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              UploadButtonWidget(
                                                content: "Upload",
                                                color: Colors.white,
                                                textColor: Colors.black,
                                              ),
                                            ],
                                          ),
                                          const Row(
                                            children: [
                                              Text(
                                                'API? (optional)',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              UploadButtonWidget(
                                                content: "Upload",
                                                color: Colors.white,
                                                textColor: Colors.black,
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
                  bool isValid = false;
                  switch (_currentStep) {
                    case 0:
                      isValid = _formKey1.currentState!.validate();
                      break;
                    case 1:
                      isValid = _formKey2.currentState!.validate();
                      break;
                    case 2:
                      isValid = _formKey3.currentState!.validate();
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
                              _formKey2.currentState!.validate() &&
                              _formKey3.currentState!.validate();

                      if (isAllFormsValid) {
                        submitBotRules("examplee", "text", "text", "text", botRole.text, companyInfo.text, listController);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }
                    }
                  }
                },

                // onStepContinue: () {
                //   bool isValid1 = true;
                //   bool isValid2 = false;
                //   bool isValid3 = false;

                //   switch (_currentStep) {
                //     case 0:
                //       setState(() {
                //         isValid1 = _formKey1.currentState!.validate();
                //       });
                //       break;
                //     case 1:
                //       setState(() {
                //         isValid2 = _formKey2.currentState!.validate();
                //       });
                //       break;
                //     case 2:
                //       setState(() {
                //         isValid3 = _formKey3.currentState!.validate();
                //       });
                //       break;
                //     default:
                //       break;
                //   }

                //   if (_currentStep < (_steps().length - 1)) {
                //     print(isValid1);
                //     print(isValid2);
                //     print(isValid3);

                //     setState(() {
                //       _currentStep += 1;
                //     });
                //   } else {
                //     if (isValid1 && isValid2 && isValid3) {
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
