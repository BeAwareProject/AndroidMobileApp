class ServerException implements Exception {
  ServerException({this.status});
  int? status;
}
