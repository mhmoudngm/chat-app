import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class userimagepicker extends StatefulWidget {

  final void Function(File _pickedimage) pickimagefn;

  const userimagepicker( this.pickimagefn) ;
  @override
  _userimagepickerState createState() => _userimagepickerState();
}

class _userimagepickerState extends State<userimagepicker> {
  final ImagePicker picker = ImagePicker();
  var pickedimage ;

  void pickiamge(ImageSource src) async {
    final pickedimagefile = await picker.getImage(source: src,imageQuality: 75,maxWidth: 150);
    if (pickedimagefile != null) {
      setState(() {
        pickedimage = File(pickedimagefile.path);
      });

      widget.pickimagefn(pickedimage);
    } else {
      print("no image seleted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: pickedimage != null ? FileImage(pickedimage) : null,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              onPressed: () => pickiamge(ImageSource.camera),
              icon: Icon(Icons.photo_camera_outlined),
              label: Text(
                "add image \n from camera",
                textAlign: TextAlign.center,
              ),

            ),
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              onPressed: () => pickiamge(ImageSource.gallery),
              icon: Icon(Icons.image_outlined),
              label: Text(
                "add image \n from gallery",
                textAlign: TextAlign.center,
              ),

            ),

          ],
        )
      ],
    );
  }
}
