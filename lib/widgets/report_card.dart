import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final Function onTap;

  ReportCard({this.title, this.image, this.description, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        height: MediaQuery.of(context).size.height * 0.15,
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        '${description.substring(0, description.length > 30 ? 31 : description.length)}...',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(image))),
              ),
            ],
          ),
        ));
  }
}
