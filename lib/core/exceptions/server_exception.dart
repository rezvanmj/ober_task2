class ServerException implements Exception {
  String message;
  int statusCode;

  ServerException({required this.message, required this.statusCode});
}
