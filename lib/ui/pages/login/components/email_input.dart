import '../../pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<String>(
      stream: presenter.emailErrorStream,
      builder: (context, snapshot){
        return TextFormField(
          decoration: InputDecoration(
              labelText: "E-mail",
              icon: Icon(Icons.email, color: Theme.of(context).primaryColor,),
              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: presenter.validateEmail,
        );
      },
    );
  }
}