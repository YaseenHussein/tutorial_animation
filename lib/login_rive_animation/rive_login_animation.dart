import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

class RiveLoginAnimation extends StatefulWidget {
  const RiveLoginAnimation({super.key});

  @override
  State<RiveLoginAnimation> createState() => _RiveLoginAnimationState();
}

class _RiveLoginAnimationState extends State<RiveLoginAnimation> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late StateMachineController? stateMachineController;
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  SMINumber? numLook;
  isCheckField() {
    isHandsUp?.change(false);
    isChecking?.change(true);
    trigSuccess?.change(false);
    trigFail?.change(false);
    numLook?.change(0);
  }

  isHandsUpField() {
    isHandsUp?.change(true);
    isChecking?.change(false);
    trigSuccess?.change(false);
    trigFail?.change(false);
    numLook?.change(0);
  }

  trigSuccessPress() {
    isHandsUp?.change(false);
    isChecking?.change(false);
    trigSuccess?.change(true);
    trigFail?.change(false);
    numLook?.change(0);
  }

  trigFailPress() {
    isHandsUp?.change(false);
    isChecking?.change(false);
    trigSuccess?.change(false);
    trigFail?.change(true);
    numLook?.change(0);
  }

  changeEyes(value) {
    numLook?.change(value.length.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                child: RiveAnimation.asset(
                  "assets/rives/animated_login_character.riv",
                  stateMachines: const ["Login Machine"],
                  onInit: (artBoard) {
                    stateMachineController =
                        StateMachineController.fromArtboard(
                            artBoard, "Login Machine");
                    if (stateMachineController == null) return;
                    artBoard.addController(stateMachineController!);
                    isChecking =
                        stateMachineController?.findInput("isChecking");
                    isHandsUp = stateMachineController?.findInput("isHandsUp");
                    trigSuccess =
                        stateMachineController?.findInput("trigSuccess");
                    trigFail = stateMachineController?.findInput("trigFail");
                    numLook = stateMachineController?.findSMI("numLook");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                child: Container(
                  width: 400,
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15,
                        offset: Offset(0, 1),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    child: Form(
                      key: _fromKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onTap: isCheckField,
                            onChanged: changeEyes,
                            controller: userNameController,
                            style: const TextStyle(fontSize: 15),
                            cursorColor: const Color.fromARGB(255, 176, 72, 99),
                            decoration: const InputDecoration(
                              hintText: "Username",
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              focusColor: Color.fromARGB(255, 176, 72, 99),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 176, 72, 99),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "places enter User Name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onTap: isHandsUpField,
                            controller: passwordController,
                            style: const TextStyle(fontSize: 15),
                            cursorColor: const Color.fromARGB(255, 176, 72, 99),
                            decoration: const InputDecoration(
                              hintText: "password",
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              focusColor: Color.fromARGB(255, 176, 72, 99),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 176, 72, 99),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "places enter password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (_fromKey.currentState!.validate()) {
                                trigSuccessPress();
                              } else {
                                trigFailPress();
                              }
                            },
                            child: Container(
                              width: 300,
                              height: 50,
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                  color: Colors.blue[500],
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
