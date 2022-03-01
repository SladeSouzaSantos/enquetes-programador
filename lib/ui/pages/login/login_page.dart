import '../pages.dart';
import '../../components/components.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(252, 227, 138, 1),
      body: Builder(
        builder: (context){
          widget.presenter.isLoadingStream.listen((isLoading) {
            if(isLoading){
              showLoading(context);
            }else{
              hideLoading(context);
            }
          });

          widget.presenter.mainErrorStream.listen((error) {
            if(error != null){
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red[900],
                    content: Text(error, textAlign: TextAlign.center,),
                  )
              );
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
                          stream: widget.presenter.emailErrorStream,
                          builder: (context, snapshot){
                            return TextFormField(
                              decoration: InputDecoration(
                                  labelText: "E-mail",
                                  icon: Icon(Icons.email, color: Theme.of(context).primaryColor,),
                                  errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: widget.presenter.validateEmail,
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 32),
                          child: StreamBuilder<String>(
                            stream: widget.presenter.passwordErrorStream,
                            builder: (context, snapshot){
                              return TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Senha",
                                    icon: Icon(Icons.lock, color: Theme.of(context).primaryColor,),
                                    errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
                                ),
                                obscureText: true,
                                onChanged: widget.presenter.validatePassword,
                              );
                            },
                          ),
                        ),
                        StreamBuilder<bool>(
                          stream: widget.presenter.isFormValidStream,
                          builder: (context, snapshot){
                            return RaisedButton(
                              onPressed: snapshot.data == true ? widget.presenter.auth : null,
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

  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }
}
