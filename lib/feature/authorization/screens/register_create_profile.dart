import 'package:flutter/material.dart';
import 'package:projekt_481_play_with_me/feature/authorization/logic/validate_functions_to_all_t_f_f.dart';
import 'package:projekt_481_play_with_me/feature/authorization/repositories/delete_all_errorinfo_textform.dart';
import 'package:projekt_481_play_with_me/feature/authorization/screens/register_extend_profile.dart';
import 'package:projekt_481_play_with_me/feature/authorization/widgets/textformfields_erriconbtn_forall.dart';
import 'package:projekt_481_play_with_me/feature/authorization/widgets/textformfields_universalform_forall.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final controllerPwd = TextEditingController();
  final controllerPwdConf = TextEditingController();
  final controllerEmail = TextEditingController();

  String? loginError;
  String? passwordError;
  String? confirmPwdError;
  String? emailError;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/registrieren.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          body: Form(
            child: Stack(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Positioned(
                  top: 400,
                  right: 50,
                  child: Column(
                    children: [
                      //=========================== EMAIL
                      Row(
                        children: [
                          InformationErrorIconButton(
                            errorMessage: emailError,
                            fieldName: fields[3].fieldName,
                            dialogContent: fields[3].dialogContext,
                          ),
                          AdaptiveTextFormField(
                            setWidth: 310,
                            controller: controllerEmail,
                            errorText: emailError,
                            labelText: "E-mail",
                            onChanged: (text) {
                              ValidationUtils.onChangedEmail(text, (error) {
                                setState(() {
                                  emailError = error;
                                });
                              });
                            },
                          ),
                        ],
                      ),

                      //========================= PASSWORD
                      Row(
                        children: [
                          InformationErrorIconButton(
                            errorMessage: passwordError,
                            fieldName: fields[1].fieldName,
                            dialogContent: fields[1].dialogContext,
                          ),
                          AdaptiveTextFormField(
                            controller: controllerPwd,
                            errorText: passwordError,
                            labelText: "Password",
                            onChanged: (text) {
                              ValidationUtils.onChangedPassword(text, (error) {
                                setState(() {
                                  passwordError = error;
                                });
                              });
                            },
                          ),
                        ],
                      ),
                      //========================== PASSWORD CONFIRM
                      Row(
                        children: [
                          InformationErrorIconButton(
                            errorMessage: confirmPwdError,
                            fieldName: fields[2].fieldName,
                            dialogContent: fields[2].dialogContext,
                          ),
                          AdaptiveTextFormField(
                            controller: controllerPwdConf,
                            errorText: confirmPwdError,
                            labelText: "Password widerhollen",
                            onChanged: (text) {
                              ValidationUtils.onChangedPassword(text, (error) {
                                setState(() {
                                  confirmPwdError = error;
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 650,
                  right: 90,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.transparent),
                    ),
                    onPressed: () {
                      ValidationUtils.validatePassword(controllerPwd.text,
                          (error) {
                        setState(() {
                          passwordError = error;
                        });
                      });
                      ValidationUtils.validatePasswordC(controllerPwdConf.text,
                          (error) {
                        setState(() {
                          confirmPwdError = error;
                        });
                      });
                      ValidationUtils.validateEmail(controllerEmail.text,
                          (error) {
                        setState(() {
                          emailError = error;
                        });
                      });

                      if (loginError == null &&
                          passwordError == null &&
                          confirmPwdError == null &&
                          emailError == null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegistrationDataScreen(
                                  email: controllerEmail.text,
                                  password: controllerPwd.text,
                                )));
                      }
                    },
                    child: Text(
                      "  Profil erstellen",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
