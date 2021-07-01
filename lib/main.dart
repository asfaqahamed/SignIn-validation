import 'package:flutter/material.dart';
import 'package:flutter_app/Welcomescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _password = '';
   _trySubmitForm() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      print('Everything looks good!');
      print(_userName);
      print(_password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        child: Center(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 35),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'This field is required';
                          }
                          if (value.trim().length < 6) {
                            return 'Username must be at least 6 characters in length';
                          }
                          return null;
                        },
                        onChanged: (value) => _userName = value,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'This field is required';
                          }
                          if (value!.trim().length < 8) {
                            return 'Password must be at least 8 characters in length';
                          }
                          if(!isPasswordCompliant(value))
                            {
                              return "Password must contain both alphabet and numeric value";
                            }
                          return null;
                        },
                        onChanged: (value) => _password = value,
                      ),
                      SizedBox(height: 20),
                      Container(
                          alignment: Alignment.centerRight,
                          child: OutlinedButton(
                              onPressed: _trySubmitForm,
                              child: Text('Sign Up')))
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
  bool isPasswordCompliant(String password, [int minLength = 8]) {
    if (password == null || password.isEmpty) {
      return false;
    }
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));

    return hasDigits & hasLowercase;
  }
}