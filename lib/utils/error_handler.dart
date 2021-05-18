
class ErrorMessage implements Exception{
  var _message;

  ErrorMessage(this._message);

  get message => _message;
  set message(value) {
    _message = value;
  }

  @override
  String toString() {
    return 'ERROR:$_message';
  }
// {"message":"Error:Name is Empty"}






}