import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xFF090129),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Image.asset('assets/logo/logo_usedev_verde.png'),
            const SizedBox(height: 25),
            const Text(
              'Hora de abraçar seu lado geek!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8FFF24),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 240,
              child: Divider(
                color: Color(0xFF8FFF24),
                thickness: 2,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Funcionamento',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Segunda a sexta - 08h às 18h',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'sac@usedev.com.br',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    '0800 541 320',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Formas de Pagamento',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/icons/ico-cartao-visa.png'),
                      Image.asset('assets/icons/ico-cartao-master.png'),
                      Image.asset('assets/icons/ico-cartao-elo.png'),
                      Image.asset('assets/icons/ico-cartao-diners.png'),
                      Image.asset('assets/icons/ico-pix.png'),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Siga nossas redes:',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/Whatsapp.png'),
                      const SizedBox(width: 10),
                      Image.asset('assets/icons/Instragam.png'),
                      const SizedBox(width: 10),
                      Image.asset('assets/icons/Tiktok.png'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25)
          ],
        ),
      ),
    );
  }
}
