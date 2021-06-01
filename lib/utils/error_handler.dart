
class ErrorMessage implements Exception{
  var _message;

  ErrorMessage(this._message);

  get message => _message;

  @override
  String toString() {
    return 'ERROR:$_message';
  }






}