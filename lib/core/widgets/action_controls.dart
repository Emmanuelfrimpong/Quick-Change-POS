// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'smart_dialog.dart';

class ActionControls extends StatefulWidget {
  const ActionControls({Key? key}) : super(key: key);

  @override
  State<ActionControls> createState() => _ActionControlsState();
}

class _ActionControlsState extends State<ActionControls> with WindowListener {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(
          message: 'Minimize',
          child: InkWell(
            onTap: () {
              WindowManager.instance.minimize();
            },
            child: const CircleAvatar(
              radius: 7,
              backgroundColor: Colors.green,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Tooltip(
          message: 'Maximize',
          child: InkWell(
            onTap: () async {
              //check if window is maximized then set size to mini size
              if (await windowManager.getSize() != const Size(800, 600)) {
                windowManager.setSize(const Size(800, 600));
                //Center the window
                windowManager.setAlignment(Alignment.center);
              } else {
                windowManager.maximize();
              }
            },
            child: const CircleAvatar(
              radius: 7,
              backgroundColor: Colors.yellow,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Tooltip(
          message: 'Close',
          child: InkWell(
            onTap: () {
              WindowManager.instance.close();
            },
            child: const CircleAvatar(
              radius: 7,
              backgroundColor: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    windowManager.addListener(this);
    _init();
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void _init() async {
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      CustomDialog.showInfo(
          title: 'Close Window',
          message: 'Are you sure you want to close this app?',
          buttonText: 'Yes',
          onPressed: () async {
            CustomDialog.dismiss();
            await windowManager.destroy();
          });
    }
  }
}
