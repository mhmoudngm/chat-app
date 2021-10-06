import 'package:chat_app/widgets/userimagepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class authform extends StatefulWidget {
  final bool isloading;
  final void Function(String email, String password, String username,File image,
      bool islogin, BuildContext ctx) submitfn;

  const authform(this.submitfn, this.isloading);

  @override
  State<authform> createState() => _authformState();
}

class _authformState extends State<authform> {
  final _formkey = GlobalKey<FormState>();
  var _email = "";
  var _password = "";
  var _username = "";
  bool _islogin = true;
  var userimagefile ;

  void pickimagefn(File pickimg) {
      userimagefile  = pickimg;
  }
  void _submit() {
    final isvalid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!_islogin && userimagefile == null ) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("please select an image."),
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ));
      return;
    }

    if (isvalid) {
      _formkey.currentState!.save();
      widget.submitfn(
          _email.trim(), _password.trim(), _username.trim(),!_islogin? userimagefile: File(""), _islogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                if (!_islogin) userimagepicker(pickimagefn),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(labelText: ("Email address")),
                  keyboardType: TextInputType.emailAddress,
                  key: ValueKey("email"),
                  validator: (val) {
                    if (val!.isEmpty || !val.contains('@')) {
                      return "please enter avild email";
                    }
                    return null;
                  },
                  onSaved: (val) => _email = val!,
                ),
                if (!_islogin)
                  TextFormField(
                    autocorrect: true,
                    decoration: InputDecoration(labelText: ("user name")),
                    keyboardType: TextInputType.name,
                    key: ValueKey("username"),
                    validator: (val) {
                      if (val!.isEmpty || val.length < 4) {
                        return "please enter at least 4 characters";
                      }
                      return null;
                    },
                    onSaved: (val) => _username = val!,
                  ),
                TextFormField(
                  decoration: InputDecoration(labelText: ("password")),
                  keyboardType: TextInputType.visiblePassword,
                  key: ValueKey("password"),
                  validator: (val) {
                    if (val!.isEmpty || val.length < 7) {
                      return "password must at least 7 characters";
                    }
                    return null;
                  },
                  onSaved: (val) => _password = val!,
                  obscureText: true,
                ),
                SizedBox(height: 12),
                if (widget.isloading) CircularProgressIndicator(),
                if (!widget.isloading)
                  RaisedButton(
                    child: Text(_islogin ? 'login' : 'sign up'),
                    onPressed: _submit,
                  ),
                if (!widget.isloading)
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          _islogin = !_islogin;
                        });
                      },
                      child: Text(_islogin
                          ? "create new account"
                          : "I already have an account"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
