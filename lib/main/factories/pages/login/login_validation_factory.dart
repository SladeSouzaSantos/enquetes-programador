import '../../../../main/builders/builders.dart';
import '../../../../validation/protocols/protocols.dart';
import '../../../../presetation/protocols/protocols.dart';
import '../../../../validation/validators/validators.dart';

Validation makeLoginValidation(){

  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations(){
  return [
    ...ValidationBuilder.field("email").required().email().build(),
    ...ValidationBuilder.field("password").required().build()
  ];
}