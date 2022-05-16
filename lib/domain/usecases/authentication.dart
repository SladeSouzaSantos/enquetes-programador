import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../entities/entities.dart';

abstract class Authentication{
  Future<AccountEntity> auth(AuthenticantionParams params);
}

class AuthenticantionParams extends Equatable{
  final String email;
  final String secret;

  @override
  List get props => [email, secret];

  AuthenticantionParams({
    @required this.email,
    @required this.secret
  });
}