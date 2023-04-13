import 'package:flutter/material.dart';

import 'package:panow/const.dart';

class AppBarOrder extends StatelessWidget {
  final String title;
  const AppBarOrder(
      {super.key,
      required this.title,
      required this.click});
  final IconButton click;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 20, right: 30, top: 35, bottom: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 96, 95, 95).withOpacity(0.25),
            spreadRadius: 5,
            blurRadius: 8,
            offset: Offset(2, 2),
          )
        ],
        // color: AppColors.yellowColor,
        color: primaryCorlor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            color: Color.fromARGB(255, 13, 76, 33),
            icon: new Icon(Icons.arrow_back, size: 25.0),
            onPressed: () {
              Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w500),
          ),
          Container(
              height: 40,
              width: 40,
              child: click,
              )
        ],
      ),
    );
  }
}
