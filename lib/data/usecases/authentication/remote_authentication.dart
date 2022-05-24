import 'package:meta/meta.dart';

import '../../http/http.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class RemoteAuthentication implements Authentication{
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    @required this.httpClient,
    @required this.url
  });

  Future<AccountEntity> auth(AuthenticationParams params) async{
    final body = RemoteAuthenticantionParams.fromDomain(params).toJson();

    try{
      await httpClient.request(
          url: url,
          method: "post",
          body: RemoteAuthenticantionParams.fromDomain(params).toJson()
      );
    }on HttpError catch(error){
      throw error == HttpError.unauthorized ? DomainError.invalidCredentials :
      DomainError.unexpected;
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

  factory RemoteAuthenticantionParams.fromDomain(AuthenticationParams params) => RemoteAuthenticantionParams(
    email: params.email,
    password: params.secret
  );

  Map toJson() => {"email" : email, "password" : password};
}