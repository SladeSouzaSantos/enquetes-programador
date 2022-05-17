import 'package:enquetes_programadores/validation/validators/validators.dart';

import 'package:test/test.dart';

void main() {
  EmailValidation sut;

  setUp((){
    sut = EmailValidation("any_field");
  });

  test("Should return null if email is empty", () {

    final error = sut.validate("");

    expect(error, null);
  });

  test("Should return null if email is null", () {

    final error = sut.validate(null);

    expect(error, null);
  });

  test("Should return null if email is valid", () {

    final error = sut.validate("pedro_eng.petroleo@hotmail.com");

    expect(error, null);
  });

  test("Should return null if email is invalid", () {

    final error = sut.validate("pedro_eng.petroleo");

    expect(error, "Campo inválido.");
  });
}