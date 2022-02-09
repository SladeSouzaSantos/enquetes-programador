import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:enquetes_programadores/data/http/http.dart';
import 'package:enquetes_programadores/data/usecases/usecases.dart';
import 'package:enquetes_programadores/domain/usecases/authentication.dart';

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
}