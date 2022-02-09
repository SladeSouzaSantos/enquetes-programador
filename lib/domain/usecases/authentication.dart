import 'package:meta/meta.dart';

import '../entities/entities.dart';

abstract class Authentication{
  Future<AccountEntity> auth(AuthenticantionParams params);
}

class AuthenticantionParams{
  final String email;
  final String secret;

  AuthenticantionParams({
    @required this.email,
    @required this.secret
  });
}