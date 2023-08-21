import 'package:flutter/material.dart';

class MaterialButtonWidget extends StatefulWidget {
  const MaterialButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
  });
  final Function() onPressed;
  final IconData icon;
  final String title;

  @override
  State<MaterialButtonWidget> createState() => _MaterialButtonWidgetState();
}

class _MaterialButtonWidgetState extends State<MaterialButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.5),
      child: MaterialButton(
        color: const Color.fromARGB(255, 56, 56, 56),
        height: 48.0,
        minWidth: 364,
        onPressed: widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Button Icon
            Icon(
              widget.icon,
            ),

            //horizontal space
            const SizedBox(width: 10.0),

            //Button Title
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
