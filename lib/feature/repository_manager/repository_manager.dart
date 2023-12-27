import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/utils/typedef.dart';
import '../database/data/data_source/database_data_source.dart';

abstract class RepositoryHelper {
  Future<Either<Failure, T>> tryToLoad<T>(LoadOrFail<T> loadOrFail);
}

@LazySingleton(as: RepositoryHelper)
class RepositoryHelperImpl implements RepositoryHelper {
  final DataBaseDataSource databaseDataSource;
  const RepositoryHelperImpl({
    required this.databaseDataSource,
  });

  @override
  Future<Either<Failure, T>> tryToLoad<T>(LoadOrFail<T> loadOrFail) async =>
      _tryToLoad(() async => await loadOrFail());

  Future<Either<Failure, T>> _tryToLoad<T>(
    Future<T> Function() tryToLoad, [
    bool isAuthorized = false,
  ]) async {
    try {
      return Right(await tryToLoad());
    } on ServerException catch (error) {
      debugPrint(error.toString());
      return Left(ServerFailure(message: error.message));
    } on UnAuthorizeException {
      await databaseDataSource.removeAllData();
      debugPrint('UnAuthorizeException');
      return Left(AuthenticationFailure());
    } on AccessDeniedException {
      debugPrint('AccessDeniedException');
      return Left(AccessDeniedFailure());
    } on MultiDeviceException {
      debugPrint('MultiDeviceException');
      return Left(MultiDeviceFailure());
    } on CancelSelectFileException {
      debugPrint('CancelSelectFileException');
      return Left(CancelSelectFileFailure());
    } on FileExtensionException catch (error) {
      debugPrint(error.toString());
      return Left(FileExtensionFailure(error.extensions));
    } on SocketException catch (error) {
      debugPrint(error.toString());
      return const Left(ServerFailure());
    } on Exception catch (error) {
      debugPrint(error.toString());
      return const Left(ServerFailure());
    }
  }
}
