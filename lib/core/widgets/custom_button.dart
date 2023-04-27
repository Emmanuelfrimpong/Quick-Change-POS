// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickchange_pos/utils/app_colors.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {Key? key,
      this.onPressed,
      required this.text,
      this.color = primaryColors,
      this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      this.radius = 5,
      this.icon})
      : super(key: key);
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final EdgeInsets? padding;
  final double radius;
  final IconData? icon;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHover: (value) {
        setState(() {
          onHover = value;
        });
      },
      child: Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color: onHover ? Colors.transparent : widget.color,
            borderRadius: BorderRadius.circular(widget.radius),
            border: Border.all(color: widget.color),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null)
                  Icon(widget.icon!,
                      size: 18, color: onHover ? widget.color : Colors.white),
                if (widget.icon != null) const SizedBox(width: 10),
                Text(
                  widget.text,
                  style: GoogleFonts.roboto(
                      color: onHover ? widget.color : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          )),
    );
  }
}
