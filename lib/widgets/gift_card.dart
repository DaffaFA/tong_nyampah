import 'package:flutter/material.dart';

class GiftCard extends StatelessWidget {
  final EdgeInsetsGeometry margin;

  GiftCard({this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152.0,
      margin: this.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        color: Colors.grey,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0x22070707),
              offset: Offset(0, 2.0),
              blurRadius: 16.0)
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              'https://target.scene7.com/is/image/Target/GUEST_175d6caf-9aeb-4a80-af84-58857a7723c4?wid=488&hei=488&fmt=pjpeg'),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          constraints: BoxConstraints.expand(height: 55.0),
          color: Colors.black,
        ),
      ),
    );
  }
}
