import 'package:flutter/material.dart';
import 'package:perto_digital_dashboard/constants/colors.dart';
import 'package:perto_digital_dashboard/constants/images.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      //problemas com layoutbuilder antes do scaffold
      return Scaffold(
        drawer: (constraints.maxHeight > 450) ? Drawer() : null,
        appBar: AppBar(
          backgroundColor: ConstantColors.greenPerto,
        ),
        body: GestureDetector(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ConstantImages.backgroundLogin3),
                fit: BoxFit.cover
                //repeat: ImageRepeat.repeat,
              ),
            ),
            constraints: BoxConstraints(),
          ),
          onTap: () => print('hi'),//Scaffold.of(context).hasAppBar,
        ),
      );
    });
  }
}
