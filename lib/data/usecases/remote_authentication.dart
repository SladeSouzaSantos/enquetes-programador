import 'package:meta/meta.dart';

import '../http/http.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

class RemoteAuthentication{
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    @required this.httpClient,
    @required this.url
  });

  Future<void> auth(AuthenticantionParams params) async{
    final body = RemoteAuthenticantionParams.fromDomain(params).toJson();

    try{
      await httpClient.request(
          url: url,
          method: "post",
          body: RemoteAuthenticantionParams.fromDomain(params).toJson()
      );
    }on HttpError{
      throw DomainError.unexpected;
    }

  }
}

class RemoteAuthenticantionParams{
  final String email;
  final String password;

  RemoteAuthenticantionParams({
    @required this.email,
    @required this.password
  });

  factory RemoteAuthenticantionParams.fromDomain(AuthenticantionParams params) => RemoteAuthenticantionParams(
    email: params.email,
    password: params.secret
  );

  Map toJson() => {"email" : email, "password" : password};
}