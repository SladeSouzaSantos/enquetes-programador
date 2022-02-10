import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:enquetes_programadores/data/http/http.dart';
import 'package:enquetes_programadores/data/usecases/usecases.dart';
import 'package:enquetes_programadores/domain/usecases/authentication.dart';
import 'package:enquetes_programadores/domain/helpers/helpers.dart';

class HttpClientSpy extends Mock implements HttpClient{}

void main(){

  HttpClientSpy httpClient;
  String url;
  RemoteAuthentication sut;

  setUp((){
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test("Should call HttpClient with correct URL", () async{
    
    final params = AuthenticantionParams(email: faker.internet.email(), secret: faker.internet.password());
    await sut.auth(params);

    verify(httpClient.request(
        url: url,
        method: "post",
        body: {"email" : params.email, "password" : params.secret}
    ));
  });

  test("Should throw UnexpectedError if HttpClient returns 400", () async{
    when(httpClient.request(url: anyNamed("url"), method: anyNamed("method"), body: anyNamed("body"))).thenThrow(HttpError.badRequest);

    final params = AuthenticantionParams(email: faker.internet.email(), secret: faker.internet.password());
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

}