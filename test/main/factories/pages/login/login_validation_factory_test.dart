import 'package:enquetes_programadores/main/factories/factories.dart';
import 'package:enquetes_programadores/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  test("Should the correct validations", () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation("email"),
      EmailValidation("email"),
      RequiredFieldValidation("password"),
    ]);

  });
}
