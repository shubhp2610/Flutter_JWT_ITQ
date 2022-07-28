import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

void main() {
  runApp(const MyApp());
}

class Person {
  var surname = "";
  var firstname = "";
  var dateofbirth = "";
  var nationality = "";
  var sex = "";
  var document = "";
  var documentno = "";
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'JWT Validator @ ITQ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var _str = "";
  var _data;
  var _col = Colors.green;
  var person = new Person();
  void _generate_jwt() {
    setState(() {
      _counter++;
      // Create a json web token
      final jwt = JWT(
        {
          'surname': "Patel",
          'firstname': "Shubh",
          'dateofbirth': "26/10/2001",
          'nationality': "Indian",
          'sex': "Male",
          'document': "nXsoUeh8zu8tLc3alPyHj43gF",
          'documentno': "5s04LrQxMoW0WD-5kA690Sf3s-gOJz5B47q3-YML4xo125rESr2"
        },
        issuer: 'IT QUICK SOLUTIONS!',
      );

// Sign it (default with HS256 algorithm)
      _str = jwt.sign(SecretKey('sign'));

      print('Signed token: $_str\n');
    });
  }

  void _verify_jwt() {
    try {
      // Verify a token
      final jwt = JWT.verify(_str, SecretKey('sign'));
      _data = jwt.payload;

      person.surname = _data['surname'];
      person.firstname = _data['firstname'];
      person.dateofbirth = _data['dateofbirth'];
      person.nationality = _data['nationality'];
      person.sex = _data['sex'];
      person.document = _data['document'];
      person.documentno = _data['documentno'];
      _data['error'] = 'none';
      _col = Colors.green;
    } on JWTExpiredError {
      _data['error'] = 'jwt expired';
      _col = Colors.red;
    } on JWTError catch (ex) {
      print(ex.message); // ex: invalid signature
    }
  }

  @override
  void initState() {
    super.initState();
    _generate_jwt();
    _verify_jwt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'SIGNED JWT',
              style: TextStyle(
                  color: Colors.black,
                  fontSize:
                      MediaQuery.of(context).size.width < 800 ? 24.0 : 30.0),
            ),
            Text(
              '$_str',
            ),
            SizedBox(
              height: 40.0,
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
                if (_data['error'] == 'none') {
                  return "Surname : ${person.surname}\nName : ${person.firstname}\ndateofbirth : ${person.dateofbirth}\nnationality : ${person.nationality}\nsex : ${person.sex}\ndocument : ${person.document}\ndocumentno : ${person.documentno}\n";
                } else {
                  return "${_data['error']}";
                }
              })(),
              style: TextStyle(color: _col, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
