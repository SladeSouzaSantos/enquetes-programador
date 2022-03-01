import '../pages.dart';
import '../../components/components.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(252, 227, 138, 1),
      body: Builder(
        builder: (context){
          presenter.isLoadingStream.listen((isLoading) {
            if(isLoading){
              showDialog(
                context: context,
                barrierDismissible: false,
                child: SimpleDialog(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Aguarde...", textAlign: TextAlign.center,)
                      ],
                    ),
                  ],
                )
              );
            }else{
              if(Navigator.canPop(context)){
                Navigator.of(context).pop();
              }
            }
          });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginHeader(),
                Headline1(text: "Login",),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    child: Column(
                      children: [
                        StreamBuilder<String>(
                          stream: presenter.emailErrorStream,
                          builder: (context, snapshot){
                            return TextFormField(
                              decoration: InputDecoration(
                                  labelText: "E-mail",
                                  icon: Icon(Icons.email, color: Theme.of(context).primaryColor,),
                                  errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: presenter.validateEmail,
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 32),
                          child: StreamBuilder<String>(
                            stream: presenter.passwordErrorStream,
                            builder: (context, snapshot){
                              return TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Senha",
                                    icon: Icon(Icons.lock, color: Theme.of(context).primaryColor,),
                                    errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
                                ),
                                obscureText: true,
                                onChanged: presenter.validatePassword,
                              );
                            },
                          ),
                        ),
                        StreamBuilder<bool>(
                          stream: presenter.isFormValidStream,
                          builder: (context, snapshot){
                            return RaisedButton(
                              onPressed: snapshot.data == true ? presenter.auth : null,
                              child: Text("Entrar".toUpperCase()),
                            );
                          },
                        ),
                        FlatButton.icon(
                            onPressed: (){},
                            icon: Icon(Icons.person),
                            label: Text("Criar Conta")
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
