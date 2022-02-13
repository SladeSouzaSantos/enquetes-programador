import 'package:enquetes_programadores/data/http/http.dart';
import 'package:enquetes_programadores/infra/http/http.dart';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ClientSpy extends Mock implements Client{}

void main(){
  HttpAdapter sut;
  ClientSpy client;
  String url;

  setUp((){
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });
  
  group("shared", (){
    test("Should throw ServerError if invalid method is provided", () async{

      final future = sut.request(url: url, method: "invalid_method");

      expect(future, throwsA(HttpError.serverError));

    });
  });

  group("post", (){
    PostExpectation mockRequest() => when(client.post(any, headers: anyNamed("headers"), body: anyNamed("body")));

    void mockResponse(int statusCode, {String body = '{"any_key":"any_values"}'}){
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    setUp((){
      mockResponse(200);
    });


    test("Should call post with correct values", () async{

      await sut.request(url: url, method: "post", body: {"any_key" : "any_values"});

      verify(client.post(
          url, 
          headers: {
            "content-type" : "application/json",
            "accept" : "application/json"
          },
          body: '{"any_key":"any_values"}'
      ));
      
    });

    test("Should call post without body", () async{

      await sut.request(url: url, method: "post");

      verify(client.post(
          any,
          headers: anyNamed("headers")
      ));

    });

    test("Should return data if post returns 200", () async{

      final response = await sut.request(url: url, method: "post");

      expect(response, {"any_key": "any_values"});

    });

    test("Should return null if post returns 200 with no data", () async{
      mockResponse(200, body: "");

      final response = await sut.request(url: url, method: "post");

      expect(response, null);

    });

    test("Should return null if post returns 204", () async{
      mockResponse(204, body: "");

      final response = await sut.request(url: url, method: "post");

      expect(response, null);

    });

    test("Should return data if post returns 204 with data", () async{
      mockResponse(204);

      final response = await sut.request(url: url, method: "post");

      expect(response, null);

    });

    test("Should return BadRequestError if post returns 400", () async{
      mockResponse(400, body: "");

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.badRequest));

    });

    test("Should return BadRequestError if post returns 400", () async{
      mockResponse(400);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.badRequest));

    });

    test("Should return UnauthorizedError if post returns 401", () async{
      mockResponse(401);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.unauthorized));

    });

    test("Should return ForBiddenError if post returns 403", () async{
      mockResponse(403);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.forBidden));

    });

    test("Should return NotFoundError if post returns 404", () async{
      mockResponse(404);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.notFound));

    });

    test("Should return ServerError if post returns 500", () async{
      mockResponse(500);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.serverError));

    });

  });

}