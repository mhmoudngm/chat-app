import 'package:flutter/material.dart';

class messagebubbles extends StatelessWidget {
  final Key key;
  final String message;
  final String username;
  final String userimage;
  final bool isme;

  const messagebubbles(this.message, this.username, this.userimage, this.isme,
      {required this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Row(
          mainAxisAlignment:
              isme ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color:
                      isme ? Colors.grey[300] : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(14),
                    topLeft: Radius.circular(14),
                    bottomLeft: isme ? Radius.circular(14) : Radius.circular(0),
                    bottomRight:
                        isme ? Radius.circular(0) : Radius.circular(14),
                  )),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isme
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline6!
                                .color),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isme
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline6!
                                .color),
                    textAlign: isme ? TextAlign.end : TextAlign.start,
                  )
                ],
              ),
            )
          ],
        ),
        Positioned(
          top: 0,
          left: !isme ? 120 : null,
          right: isme ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userimage),
          ),
        ),
      ],
    );
  }
}
