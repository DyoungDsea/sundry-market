class ResultNotFoundError implements Exception {
  final String message;

  ResultNotFoundError(this.message);
}

class AccessDeniedError implements Exception {
  final String message;

  AccessDeniedError(this.message);
}

class LoginFailedError implements Exception {
  final String message;

  LoginFailedError(this.message);
}

class ServerError implements Exception {
  final String message;

  ServerError(this.message);
}

class NetworkError implements Exception {
  final String message;

  NetworkError(this.message);
}
