import 'package:flutter/material.dart';
import 'package:hni_customers_app/app/app.dart';
import 'package:hni_customers_app/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const App());
}
