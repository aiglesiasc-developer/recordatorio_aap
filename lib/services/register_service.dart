import 'package:recordatorio_aap/data/repository.dart';

class RegisterService {

  final Repository repository = Repository();

  void createUser(String username, String password, String repeatPassword, String email){
    repository.fechUserInfoByUsername(username).then((userResponse) {
      if(userResponse != null){
        print(userResponse.userDetailList[0].username);
      } else {
        print("usuario encontrado");
      }
    });
  }
}