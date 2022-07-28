
import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class Session {
  var user_id = "";
  var action_id = "";
  var session_id = "";
  var timestamp = "";
}


class ScreenB extends StatelessWidget {
  const ScreenB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyHomePage(title: "title");
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _str = "";
  var _data;
  var error="";
  var _col = Colors.deepOrange;
  var session = new Session();
  var ijwt ="";


  void _verify_jwt() {
    try {
      // Verify a token
      final jwt = JWT.verify(_str, SecretKey('sign'));
      _data = jwt.payload;

      session.user_id = _data['user_id'];
      session.action_id = _data['action_id'];
      session.session_id = _data['session_id'];
      session.timestamp= _data['timestamp'];
      error = 'none';
      _col = Colors.green;
    } on JWTExpiredError {
      error = 'jwt expired';
      _col = Colors.red;
    } on JWTError catch (ex) {
      error = ex.message;
      _col = Colors.red;
    }
    print(error);
  }

  @override
  void initState() {
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter token',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    else{
                      ijwt = value;
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        _str = ijwt;
                        _verify_jwt();
                        setState(() {});
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
                Text(
                  'JWT DETAILS',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize:
                      MediaQuery.of(context).size.width < 800 ? 24.0 : 30.0),
                ),
                Text(
                  (() {
                    if(error != ""){
                      if(error == 'none') {
                        return "Status : VALID  \nuser_id : ${session.user_id}\naction_id : ${session.action_id}\nsession_id : ${session.session_id}\ntimestamp : ${session.timestamp}";
                      } else {
                        return "$error";
                      }
                    }else{
                      return "Submit a token!";
                    }})(),
                  style: TextStyle(color: _col, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


