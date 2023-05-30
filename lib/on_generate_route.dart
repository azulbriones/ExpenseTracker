import 'package:flutter/material.dart';
import 'package:flutter_project_app/app_const.dart';
import 'package:flutter_project_app/features/transactions/domain/entities/transaction_entity.dart';
import 'package:flutter_project_app/features/transactions/presentation/pages/add_transaction_page.dart';
import 'package:flutter_project_app/features/transactions/presentation/pages/update_transaction_page.dart';
import 'package:flutter_project_app/features/users/presentation/pages/sign_in_page.dart';
import 'package:flutter_project_app/features/users/presentation/pages/sign_up_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.signInPage:
        {
          return materialBuilder(widget: const SignInPage());
        }
      case PageConst.signUpPage:
        {
          return materialBuilder(widget: const SignUpPage());
        }
      case PageConst.addTransactionPage:
        {
          if (args is String) {
            return materialBuilder(
                widget: AddTransactionPage(
              uid: args,
            ));
          } else {
            return materialBuilder(
              widget: const ErrorPage(),
            );
          }
        }
      case PageConst.updateTransactionPage:
        {
          if (args is TransactionEntity) {
            return materialBuilder(
                widget: UpdateTransactionPage(
              transactionEntity: args,
            ));
          } else {
            return materialBuilder(
              widget: const ErrorPage(),
            );
          }
        }
      default:
        return materialBuilder(widget: const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("error"),
      ),
      body: const Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
