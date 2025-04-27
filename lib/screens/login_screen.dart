import 'package:flutter/material.dart';
import 'package:recordatorio_aap/data/models/user_details.dart';
import 'package:recordatorio_aap/data/repository.dart';
import 'package:recordatorio_aap/screens/register_screen.dart';
import 'package:recordatorio_aap/styles/colors/app_colors.dart';
import 'package:recordatorio_aap/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Repository repository = Repository();
  final Utils utils = Utils();

  bool _obscurePassword = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "Calendario",
          style: TextStyle(color: AppColors.background),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Spacer(),
            Image.asset("assets/images/acceso.png", width: 250),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: TextField(
                //usuario
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: "Usuario",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TextField(
                //password
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Contraseña",
                  prefixIcon: IconButton(icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                obscureText: true,
              ),
            ),
            Padding(
              //entrar
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    setState(() {
                      loginUser();
                    });
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            Padding(
              //registro
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(usernameTextfield: _usernameController.text)));
                  },
                  style: FilledButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    backgroundColor: AppColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: AppColors.primary),
                    ),
                  ),
                  child: Text("Registro"),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    final resultado = await repository.checkUserExist(username, username);

    if (resultado['usernameExists'] == true ||
        resultado['emailExists'] == true) {
      UserDetails user = UserDetails(
        username: username,
        password: password,
        email: null,
      );
      final response = await repository.loginUser(user);
      if (response['response'] == 'ok') { //compruebo si coninciden las contraseñas de los datos
        print("Agregar redireccion a la pantalla de home");
      } else {
        utils.mostrarMensaje(context, "El usuario y/o la contraseña son incorrectos");
      }
    } else {
      utils.mostrarMensaje(context, "El usuario y/o la contraseña son incorrectos");
      return;
    }
  }
}
