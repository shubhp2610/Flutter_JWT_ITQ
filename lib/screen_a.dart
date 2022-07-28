import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/services.dart';


class ScreenA extends StatelessWidget {
  const ScreenA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GeneratePage(title: "title");
  }
}

class GeneratePage extends StatefulWidget {
  const GeneratePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  var _str = "";
  var token = "";
  var error="";
  var _col = Colors.green;
  var uidjwt ="";
  var aidjwt ="";
  var sidjwt ="";


  void _generate_jwt() {
    setState(() {
      // Create a json web token
      final jwt = JWT(
        {
          'user_id': uidjwt,
          'action_id': aidjwt,
          'session_id': sidjwt,
          'timestamp' :(DateTime.now().millisecondsSinceEpoch).toString()
        },
        issuer: 'IT QUICK SOLUTIONS!',
      );

// Sign it (default with HS256 algorithm)
      token = jwt.sign(SecretKey('sign'));

      print('Signed token: $token\n');
    });
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
                    labelText: 'Enter user_id',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    else{
                      uidjwt = value;
                    }
                    return null;
                  },
                ),TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter action_id',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    else{
                      aidjwt = value;
                    }
                    return null;
                  },
                ),TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter session_id',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    else{
                      sidjwt = value;
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
                        //_str = ijwt;
                        _generate_jwt();
                        setState(() {});
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
                Text(
                  'JWT TOKEN',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize:
                      MediaQuery.of(context).size.width < 800 ? 24.0 : 30.0),
                ),
                Text(
                  '$token',
                  style: TextStyle(color: _col, fontSize: 16),
                ),Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: token));
                    },
                    child: const Text('COPY'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//onTap: () {
//   Clipboard.setData(ClipboardData(text: "your text"));
// },