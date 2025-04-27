import 'package:flutter/material.dart';

class Utils {

  void mostrarMensaje(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), duration: Duration(seconds: 2)),
    );
  }

}