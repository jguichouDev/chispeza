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

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 12,
            child: Container(
              color: on ? azul : blanco,
              alignment: Alignment.center,
              child: Text(
                on ? "VAMOS CANTEN LOS CRUZADOS" : "¡APRIETA EL BOTÓN!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: on ? blanco : azul,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: on ? blanco : azul,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => on ? stopFlash() : startFlash(),
                child: Image.asset('assets/images/ic_flash.png', width: 120),
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Container(
              color: on ? azul : blanco,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    on ? "" : "¡Y QUE COMIENCE LA CHISPEZA!",
                    style: TextStyle(
                      fontSize: 28,
                      color: on ? blanco : azul,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/images/ic_launcher.png', width: 32),
                  const SizedBox(height: 10),
                  Text("DESARROLLADO POR"),
                  Text("ACDC"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
