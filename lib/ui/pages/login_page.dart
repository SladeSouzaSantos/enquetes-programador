import '../components/components.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(252, 227, 138, 1),
      body: SingleChildScrollView(
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
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "E-mail",
                          icon: Icon(Icons.email, color: Theme.of(context).primaryColor,)
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 32),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "Senha",
                            icon: Icon(Icons.lock, color: Theme.of(context).primaryColor,)
                        ),
                        obscureText: true,
                      ),
                    ),

                    RaisedButton(
                      onPressed: null,
                      child: Text("Entrar".toUpperCase()),
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
      ),
    );
  }
}
