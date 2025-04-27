import 'package:flutter/material.dart';
import 'package:recordatorio_aap/data/models/user_details.dart';
import 'package:recordatorio_aap/data/repository.dart';
import 'package:recordatorio_aap/services/register_service.dart';
import 'package:recordatorio_aap/styles/colors/app_colors.dart';
import 'package:recordatorio_aap/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  final String usernameTextfield;

  const RegisterScreen({super.key, required this.usernameTextfield});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final Repository repository = Repository();
  final RegisterService registerService = RegisterService();
  final Utils utils = Utils();

  bool _obscurePassword = true;
  bool _obscureRepetaPassword = true;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.usernameTextfield);
  }

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
            Column(
              children: [
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
                      prefixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          _obscurePassword = !_obscurePassword;
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: TextField(
                    //password repeat
                    controller: _repeatPasswordController,
                    decoration: InputDecoration(
                      hintText: "Repetir contraseña",
                      prefixIcon: IconButton(
                        icon: Icon(
                          _obscureRepetaPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          _obscureRepetaPassword = !_obscureRepetaPassword;
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: TextField(
                    //email
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
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
                          validarRegistro(context);
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
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void validarRegistro(BuildContext context) async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String repeatPassword = _repeatPasswordController.text;

    final resultado = await repository.checkUserExist(username, email);

    var allFillings = true;
    var campos = [username, email, password, repeatPassword];
    for (var campo in campos) {
      if (campo.isEmpty) {
        allFillings = false;
        break;
      }
    }

    if (resultado['usernameExists'] == true ||
        resultado['emailExists'] == true) {
      utils.mostrarMensaje(context, 'Ya existe un usuario con esos datos');
      return;
    }

    if (password != repeatPassword) {
      utils.mostrarMensaje(context, "Las contraseñas no coinciden");
      return;
    }

    if (!allFillings) {
      utils.mostrarMensaje(context, "Debes rellenar todos los campos");
      return;
    }

    // Si todo bien, llamar a tu función de registro
    print('Registrando usuario...');
    var user = UserDetails(
      username: username,
      password: password,
      email: email,
    );
    repository.registerUser(user);
  }
}
