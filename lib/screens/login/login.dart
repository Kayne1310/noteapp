import 'package:flutter/material.dart';
import 'package:flutter_bloc_cubit/screens/list_note/list_note.dart';

class LoginPage extends StatelessWidget {
  static const String route = "LoginPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Text(
              "Login Form",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: "User Name"),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: "Pass Word"),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ListNoteApp.route);
              },
              child:Text("Login"),
       
            ),
          ],
        ),
      ),
    );
  }
}
