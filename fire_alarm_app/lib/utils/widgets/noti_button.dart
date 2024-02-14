import 'package:flutter/material.dart';

class NotiButton extends StatelessWidget {
  final String textButton;
  final String image;
  final Color color;
  const NotiButton({
    super.key,
    required this.textButton,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textButton,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: 'DM Sans',
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: color,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 1), blurRadius: 3)
              ]),
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              image,
              width: 40,
              height: 40,
            ),
          ),
        )
      ],
    );
  }
}
