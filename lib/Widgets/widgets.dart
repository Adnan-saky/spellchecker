import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key, required this.widget,}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .27,
        width: MediaQuery.of(context).size.width * .95,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 3,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(
                1.0,
                2.0,
              ), //Offset
              blurRadius: 2.0,
              spreadRadius: 1.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
        ),
      child: widget,
    );
  }
}
