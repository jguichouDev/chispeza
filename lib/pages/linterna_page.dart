import 'dart:async';
import 'package:flutter/material.dart';
import '../services/flash_service.dart';

class LinternaPage extends StatefulWidget {
  const LinternaPage({super.key});

  @override
  State<LinternaPage> createState() => _LinternaPageState();
}

class _LinternaPageState extends State<LinternaPage> {
  bool flashing = false;
  bool flashOn = false;
  Timer? timer;

  final delay = const Duration(milliseconds: 110);

  final azul = const Color(0xFF0D47A1);
  final blanco = Colors.white;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mostrarMensajeInicial();
    });
  }

  void mostrarMensajeInicial() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Linterna Chispeza"),
        content: const Text("¡Vamos la Católica!"),
        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context), child: const Text("OK"))
        ],
      ),
    );
  }

  void startFlash() {
    flashing = true;
    timer = Timer.periodic(delay, (_) async {
      flashOn = !flashOn;
      await FlashService.setFlash(flashOn);
    });
    setState(() {});
  }

  void stopFlash() async {
    flashing = false;
    timer?.cancel();
    await FlashService.setFlash(false);
    setState(() {});
  }

  @override
  void dispose() {
    stopFlash();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final on = flashing;

    final screenWidth = MediaQuery.of(context).size.width;
    final buttonSize = screenWidth * 0.55;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            // FRANJA SUPERIOR
            Expanded(
              flex: 12,
              child: Container(
                width: double.infinity,
                color: on ? azul : blanco,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    on
                        ? "VAMOS CANTEN LOS CRUZADOS"
                        : "¡APRIETA EL BOTÓN!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'BabaPro',
                      fontSize: screenWidth * 0.09,
                      color: on ? blanco : azul,
                    ),
                  ),
                ),
              ),
            ),

            // FRANJA CENTRAL
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                color: on ? blanco : azul,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => on ? stopFlash() : startFlash(),
                  child: Image.asset(
                    'assets/images/ic_flash.png',
                    width: buttonSize,
                    height: buttonSize,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // FRANJA INFERIOR
            Expanded(
              flex: 12,
              child: Container(
                width: double.infinity,
                color: on ? azul : blanco,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          on
                              ? ""
                              : "¡Y QUE COMIENCE LA CHISPEZA!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'BabaPro',
                            fontSize: screenWidth * 0.08,
                            color: on ? blanco : azul,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Image.asset(
                      'assets/images/ic_launcher.png',
                      width: 42,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "DESARROLLADO POR",
                      style: TextStyle(
                        fontFamily: 'BabaPro',
                        fontSize: 14,
                        color: on ? blanco : azul,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "AGRUPACIÓN CRUZADOS DEL CÓRNER ACDC",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'BabaPro',
                          fontSize: 14,
                          color: on ? blanco : azul,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
