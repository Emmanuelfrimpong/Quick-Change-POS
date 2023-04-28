// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog {
  static void showLoading({required String message}) {
    SmartDialog.showLoading(
      msg: message,
    );
  }

  static void dismiss() {
    SmartDialog.dismiss();
  }

  static void showToast({required String message}) {
    SmartDialog.showToast(
      message,
    );
  }

  static void showError({required String title, String? message}) {
    SmartDialog.show(
      maskColor: Colors.transparent,
      builder: (_) {
        return Container(
          width: 300,
          height: 150,
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.9),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                if (message != null)
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style:
                        GoogleFonts.roboto(color: Colors.black, fontSize: 13),
                  ),
                const Spacer(),
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black26, width: 1.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextButton(
                        onPressed: () => SmartDialog.dismiss(),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10)),
                        ),
                        child: Text(
                          'Okay',
                          style: GoogleFonts.nunito(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showSuccess({required String title, String? message}) {
    SmartDialog.show(
      maskColor: Colors.transparent,
      builder: (_) {
        return Container(
          width: 300,
          height: 150,
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.9),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                if (message != null)
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style:
                        GoogleFonts.roboto(color: Colors.black, fontSize: 13),
                  ),
                const Spacer(),
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black26, width: 1.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextButton(
                        onPressed: () => SmartDialog.dismiss(),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10)),
                        ),
                        child: Text(
                          'Okay',
                          style: GoogleFonts.nunito(
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showInfo(
      {required String title,
      String? message,
      VoidCallback? onPressed,
      required String buttonText,
      String? buttonText2,
      VoidCallback? onPressed2}) async {
    SmartDialog.show(
      maskColor: Colors.transparent,
      builder: (_) {
        return Container(
          width: 300,
          height: 150,
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.9),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              if (message != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    style:
                        GoogleFonts.roboto(color: Colors.black, fontSize: 13),
                  ),
                ),
              const Spacer(),
              Container(
                height: 30,
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.black26, width: 1.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: TextButton(
                      onPressed: onPressed,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(10)),
                      ),
                      child: Text(
                        buttonText,
                        style: GoogleFonts.nunito(
                            color: Colors.green,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                    const VerticalDivider(
                      color: Colors.black26,
                      thickness: 1.5,
                    ),
                    Expanded(
                        child: TextButton(
                      onPressed: () => SmartDialog.dismiss(),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(10)),
                      ),
                      child: Text(
                        buttonText2 ?? 'Cancel',
                        style: GoogleFonts.nunito(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showCustom(
      {required Widget ui, SmartDialogController? controller}) async {
    SmartDialog.show(
      controller: controller,
      maskColor: Colors.transparent,
      builder: (_) {
        return ui;
      },
    );
  }

  static Future<void> showImageDialog({String? path}) async {
    SmartDialog.show(
      maskColor: Colors.transparent,
      builder: (_) {
        return Card(
          elevation: 10,
          child: Container(
              width: 500,
              height: 500,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(path!), fit: BoxFit.fill)),
              child: Transform.translate(
                offset: const Offset(30, -30),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    color: Colors.white,
                    highlightColor: Colors.white,
                    padding: EdgeInsets.zero,
                    icon: const CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 40,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    onPressed: () {
                      CustomDialog.dismiss();
                    },
                  ),
                ),
              )),
        );
      },
    );
  }
}
