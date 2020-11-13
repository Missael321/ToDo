enum Energia { baja, media, alta }

class TaskModel {
  String _titulo;
  String _fecha;
  Energia _energia;

  TaskModel(this._titulo, this._fecha, this._energia);

  String get titulo => this._titulo;
  String get fecha => this._fecha;
  Energia get energia => this._energia;
}
