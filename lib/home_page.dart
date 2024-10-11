import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StateMachineController? _stateMachineController;
  Artboard? mainArtBoard;
  SMIBool? check;

  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/fire_button.riv').then(
      (riveByteDate) {
        var riveFile = RiveFile.import(riveByteDate);
        var mArtBoard = riveFile.mainArtboard;
        _stateMachineController =
            StateMachineController.fromArtboard(mArtBoard, "State Machine 1");

        if (_stateMachineController != null) {
          mArtBoard.addController(_stateMachineController!);
          mainArtBoard = mArtBoard;

          check = _stateMachineController!.findSMI("ON");

          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainArtBoard != null
          ? InkWell(
              onTap: () {
                check!.value = !check!.value;
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Rive(
                  artboard: mainArtBoard!,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(),
    );
  }
}
