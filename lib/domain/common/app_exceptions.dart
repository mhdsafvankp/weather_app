class AppException implements Exception {
  final String message;

  AppException({this.message = "Oops! something went wrong"});

  @override
  String toString() {
    return message;
  }
}

class BadRequestException extends AppException {
  final String suffix;

  BadRequestException({this.suffix = ""})
      : super(message: "Invalid Request: $suffix");
}

class UnauthorisedException extends AppException {
  final String suffix;

  UnauthorisedException({this.suffix = ""})
      : super(message: "Unauthorised Request: $suffix");
}

class InvalidInputException extends AppException {
  final String suffix;

  InvalidInputException({this.suffix = ""})
      : super(message: "Invalid Input: $suffix");
}

class FetchDataException extends AppException {
  final String suffix;

  FetchDataException({this.suffix = ""})
      : super(message: "Error During Communication: $suffix");
}

class AppSocketException extends AppException {
  final String suffix;

  AppSocketException({this.suffix = ""})
      : super(message: "No Internet connection: $suffix");
}
