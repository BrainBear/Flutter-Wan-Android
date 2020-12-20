

class HttpException implements Exception {

  final int statusCode;
  final String message;
  final String ext;

  HttpException(this.statusCode, this.message, [this.ext = ""]);

}