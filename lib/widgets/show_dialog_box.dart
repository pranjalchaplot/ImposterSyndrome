import 'package:flutter/material.dart';

import '../app_configs.dart';

class ShowDialogBox extends StatefulWidget {
  final Widget showDialogChild;
  const ShowDialogBox({super.key, required this.showDialogChild});

  @override
  State<ShowDialogBox> createState() => _ShowDialogBoxState();
}

class _ShowDialogBoxState extends State<ShowDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: AppConfigs.popUpDisplayGradient,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(20),
          child: widget.showDialogChild,
        ));
  }
}
