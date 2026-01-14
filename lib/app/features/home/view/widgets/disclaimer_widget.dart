import 'package:flutter/material.dart';

class DisclaimerWidget extends StatelessWidget {
  const DisclaimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xFFEFEFEF),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Desenvolvido por Yago Oliveira para teste da Alura / FIAP. '
          'Projeto fictício sem fins comerciais',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
