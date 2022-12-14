import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:perto_digital_dashboard/constants/colors.dart';
import 'package:perto_digital_dashboard/constants/images.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 450) {
          return Container(
            width: MediaQuery.of(context).size.width,
            color: ConstantColors.greenPerto,
            child: ContentLogin(),
          );
        } else if (constraints.maxWidth > 1100) {
          return LoginBackground(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextContainer(),
                ContainerLogin(),
              ],
            ),
          );
        } else {
          return LoginBackground(
            child: ContainerLogin(),
          );
        }
      }),
    );
  }
}

class TextContainer extends StatelessWidget {
  const TextContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 400,
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Faça seu login na plataforma.',
            style: TextStyle(
              color: ConstantColors.azulCinza,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle styleLoginContent =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

class CustomTextFormField extends StatefulWidget {
  Function? callback;
  bool isPass;
  CustomTextFormField({super.key, this.isPass = false, this.callback});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          if (widget.isPass) {
            return 'Por favor digite sua senha.';
          } else {
            return 'Por favor digite seu e-mail.';
          }
        }
        if (!widget.isPass && value.isNotEmpty) {
          bool isEmail = EmailValidator.validate(value);
          if (!isEmail) {
            return 'Digite um e-mail válido';
          }
        }
        (widget.callback != null) ? widget.callback!(value) : null;
      },
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      obscureText: widget.isPass ? !isVisible : false,
      decoration: InputDecoration(
          focusColor: Colors.white,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          suffixIcon: widget.isPass
              ? IconButton(
                  icon:
                      Icon(isVisible ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    isVisible = !isVisible;
                    setState(() {});
                  },
                )
              : null),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          'Acessar',
          style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
    );
  }
}

class ContentLogin extends StatefulWidget {
  const ContentLogin({super.key});

  @override
  State<ContentLogin> createState() => _ContentLoginState();
}

class _ContentLoginState extends State<ContentLogin> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(children: [
        const SizedBox(height: 40),
        Image.asset(width: 150, ConstantImages.logoPerto),
        const SizedBox(height: 40),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('E-mail:', style: styleLoginContent),
              CustomTextFormField(
                callback: (String? value) {
                  print(value);
                },
              ),
              const SizedBox(height: 20),
              Text('Senha:', style: styleLoginContent),
              Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: ConstantColors.azulCinza,
                        ),
                  ),
                  child: CustomTextFormField(isPass: true)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          child: LoginButton(),
          onTap: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/dashboard', (route) => false);
              //returnSnackbar(context, 'Autorizado!');
            } else {}
          },
        ),
        const SizedBox(height: 10),
      ]),
    );
  }
}

class ContainerLogin extends StatelessWidget {
  const ContainerLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        //height: 430,
        width: 250,
        decoration: BoxDecoration(
          color: ConstantColors.greenPertoSuave,
          borderRadius: BorderRadius.circular(30),
        ),
        child: ContentLogin(),
      ),
    );
  }
}

class LoginBackground extends StatelessWidget {
  final Widget child;
  const LoginBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 100),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ConstantImages.backgroundLogin),
          fit: BoxFit.cover,
          //repeat: ImageRepeat.repeat,
        ),
      ),
      child: Center(child: child),
    );
  }
}

returnSnackbar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(
      text,
      textAlign: TextAlign.center,
    )),
  );
}
