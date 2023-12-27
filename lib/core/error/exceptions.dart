import 'package:equatable/equatable.dart';

/// Throw this exception in DataSource if API return failure response.
///
class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException({this.message});

  @override
  List<Object?> get props => [message];
}

class UnAuthorizeException extends Equatable implements Exception {
  const UnAuthorizeException();
  @override
  List<Object?> get props => [];
}

class AccessDeniedException extends Equatable implements Exception {
  const AccessDeniedException();
  @override
  List<Object?> get props => [];
}

class MultiDeviceException extends Equatable implements Exception {
  const MultiDeviceException();
  @override
  List<Object?> get props => [];
}

class FileSizeException extends Equatable implements Exception {
  final int size;
  const FileSizeException(this.size);

  @override
  List<Object?> get props => [size];
}

class FileExtensionException extends Equatable implements Exception {
  final String extensions;
  const FileExtensionException(this.extensions);

  @override
  List<Object?> get props => [extensions];
}

class CancelSelectFileException extends Equatable implements Exception {
  const CancelSelectFileException();
  @override
  List<Object?> get props => [];
}
