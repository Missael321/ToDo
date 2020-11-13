import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _ctrCorreo = TextEditingController();
  final _ctrPass = TextEditingController();
  final user = 'missael';
  final pass = '1234';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              _campoCorreo(),
              _campoPass(),
              _campoBoton(context),
            ],
          ),
        ));
  }

  Widget _campoCorreo() {
    return TextFormField(
      controller: _ctrCorreo,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        fillColor: Colors.blue,
        focusColor: Colors.blue,
        hintText: 'Usuario',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Debe escribir el nombre de Usuario';
        }
        return null;
      },
    );
  }

  Widget _campoPass() {
    return TextFormField(
      controller: _ctrPass,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        fillColor: Colors.blue,
        focusColor: Colors.blue,
        hintText: 'Contraseña',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Debe escribir su Contraseña';
        }
        return null;
      },
    );
  }

  Widget _campoBoton(context) {
    return RaisedButton(
      child: Text('Ingresar'),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          if (_ctrCorreo.text == user && _ctrPass.text == pass) {
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Datos Incorrectos'),
            ));
          }
        }
      },
    );
  }
}
