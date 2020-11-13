import 'package:scoped_model/scoped_model.dart';
import 'package:todo/src/models/TaskListModel.dart';
import 'package:flutter/material.dart';
import 'package:todo/src/models/TaskModel.dart';

class TaskForm extends StatefulWidget {
  TaskForm({Key key}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<FormState>();
  String titulo;
  String fecha;

  TextEditingController _inputTitulo = TextEditingController();
  TextEditingController _inputFecha = TextEditingController();
  Energia _inputEnergia = Energia.baja;

  @override
  Widget build(BuildContext context) {
    TaskModel task = ModalRoute.of(context).settings.arguments;
    if (task != null) {
      print(task.titulo);
      titulo = task.titulo.toString();
      return Form(
        key: _key,
        child: ListView(
          children: [
            _campoTitle(),
            _campoDate(context),
            _campoEnergia(),
            _botonGuardar()
          ],
        ),
      );
    }
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          _campoTitulo(),
          _campoFecha(context),
          _campoEnergia(),
          _botonGuardar()
        ],
      ),
    );
  }

  Widget _campoTitulo() {
    return TextFormField(
      controller: _inputTitulo,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        fillColor: Colors.blue,
        focusColor: Colors.blue,
        hintText: 'Tarea',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Debe Agregar una Tarea';
        }
        return null;
      },
    );
  }

  Widget _campoTitle() {
    return TextFormField(
      initialValue: titulo,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        fillColor: Colors.blue,
        focusColor: Colors.blue,
        hintText: titulo,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Debe Agregar una Tarea';
        }
        return null;
      },
    );
  }

  Widget _campoFecha(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      controller: _inputFecha,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        fillColor: Colors.blue,
        focusColor: Colors.blue,
        hintText: 'Fecha',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Selecciona una Fecha';
        }
        return null;
      },
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        _selectDate(context);
      },
    );
  }

  Widget _campoEnergia() {
    return DropdownButton(
      value: _inputEnergia,
      items: [
        DropdownMenuItem(
          child: Text(
            Energia.baja.toString(),
          ),
          value: Energia.baja,
        ),
        DropdownMenuItem(
          child: Text(Energia.media.toString()),
          value: Energia.media,
        ),
        DropdownMenuItem(
          child: Text(Energia.alta.toString()),
          value: Energia.alta,
        ),
      ],
      onChanged: (value) {
        setState(() {
          _inputEnergia = value;
        });
      },
    );
  }

  Widget _botonGuardar() {
    return RaisedButton(
      textColor: Colors.white,
      color: Colors.blue,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(50.0),
      ),
      child: Text('Agregar Tarea'),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          ScopedModel.of<TaskListModel>(context, rebuildOnChange: true)
              .add(_createTask());
        }
        _inputTitulo.clear();
        _inputFecha.clear();
      },
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (picked != null) {
      setState(() {
        String dia = '${picked.day}';
        if (picked.day < 10) {
          dia = '0${picked.day}';
        }
        _inputFecha.text = '$dia-${picked.month}-${picked.year}'.toString();
        fecha = _inputFecha.text;
      });
    }
  }

  Widget _campoDate(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      initialValue: fecha,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        fillColor: Colors.blue,
        focusColor: Colors.blue,
        hintText: 'Fecha',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Selecciona una Fecha';
        }
        return null;
      },
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        _selectDate(context);
      },
    );
  }

  TaskModel _createTask() {
    return TaskModel(_inputTitulo.text, _inputFecha.text, _inputEnergia);
  }
}
