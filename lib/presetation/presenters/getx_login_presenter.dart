import 'package:enquetes_programadores/domain/usecases/usecases.dart';

import '../../ui/pages/pages.dart';
import '../../domain/helpers/domain_error.dart';
import '../../domain/usecases/authentication.dart';
import '../protocols/protocols.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter{
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String _email;
  String _password;

  var _emailError = RxString();
  var _passwordError = RxString();
  var _mainError = RxString();
  var _navigateToStream = RxString();
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  Stream<String> get emailErrorStream => _emailError.stream;
  Stream<String> get passwordErrorStream => _passwordError.stream;
  Stream<String> get mainErrorStream => _mainError.stream;
  Stream<String> get navigateToStream => _navigateToStream.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  Stream<bool> get isLoadingStream => _isLoading.stream;

  GetxLoginPresenter({@required this.validation, @required this.authentication, @required this.saveCurrentAccount});

  void _validateForm(){
    _isFormValid.value = _emailError.value == null && _passwordError.value == null && _email != null && _password != null;
  }

  void validateEmail(String email){
    _email = email;
    _emailError.value = validation.validate(field: "email", value: email);
    _validateForm();
  }

  void validatePassword(String password){
    _password = password;
    _passwordError.value = validation.validate(field: "password", value: password);
    _validateForm();
  }

  Future<void> auth() async{
    try{
      _isLoading.value = true;

      final account = await authentication.auth(AuthenticationParams(email: _email, secret: _password));
      await saveCurrentAccount.save(account);
      _navigateToStream.value = "/surveys";
    }on DomainError catch(error){
      _mainError.value = error.description;
      _isLoading.value = false;
    }
  }

  void dispose(){
  }

}