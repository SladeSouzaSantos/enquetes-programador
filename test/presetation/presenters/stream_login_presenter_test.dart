import 'package:enquetes_programadores/domain/usecases/authentication.dart';

import 'package:enquetes_programadores/presetation/presenters/presenters.dart';
import 'package:enquetes_programadores/presetation/protocols/protocols.dart';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ValidationSpy extends Mock implements Validation{}
class AuthenticationSpy extends Mock implements Authentication{

}

void main(){
  StreamLoginPresenter sut;
  AuthenticationSpy authentication;
  ValidationSpy validation;
  String email;
  String password;

  PostExpectation mockValidationCall(String field) =>
      when(validation.validate(field: field == null ? anyNamed("field") : field, value: anyNamed("value")));

  void mockValidation({String field, String value}){
    mockValidationCall(field).thenReturn(value);
  }

  setUp((){
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    sut = StreamLoginPresenter(validation: validation, authentication: authentication);
    email = faker.internet.email();
    password = faker.internet.password();

    mockValidation();
  });

  test("Should call Validation with correct email", (){
    sut.validateEmail(email);

    verify(validation.validate(field: "email", value: email)).called(1);
  });

  test("Should emit email error if validation fails", (){
    mockValidation(value: "error");

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, "error")));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test("Should emit null if validation succeds", (){

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test("Should call Validation with correct password", (){
    sut.validatePassword(password);

    verify(validation.validate(field: "password", value: password)).called(1);
  });

  test("Should emit password error if validation fails", (){
    mockValidation(value: "error");

    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, "error")));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test("Should emit null if validation succeds", (){
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test("Should emit password error if validation fails", (){
    mockValidation(field: "email", value: "error");

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, "error")));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test("Should emit nulls if validation succeds", () async{
    
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));
    
    sut.validateEmail(email);

    await Future.delayed(Duration.zero);

    sut.validatePassword(password);
  });

  test("Should call Authentication with correct values", () async{

    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();

    verify(authentication.auth(AuthenticantionParams(email: email, secret: password))).called(1);
  });

}