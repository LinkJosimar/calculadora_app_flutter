import 'package:flutter/material.dart';
import '../model/resultados_imc.dart';
import 'calculadora_imc.dart';
import 'resultados_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;
  List<ResultadosImc> resultados = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
      ),
      body: Column(children: [
        Expanded(
            child: PageView(
          controller: controller,
          onPageChanged: (value) {
            setState(() {
              posicaoPagina = value;
            });
          },
          children: [
            CalcImcPage(novoItemAdicionado: (item) {
              setState(() {
                resultados.add(item);
              });
            }),
            ResultadosPage(
              resultados: resultados,
            )
          ],
        )),
        BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              controller.jumpToPage(value);
            },
            currentIndex: posicaoPagina,
            items: const [
              BottomNavigationBarItem(
                  label: "Calcular IMC", icon: Icon(Icons.calculate)),
              BottomNavigationBarItem(
                  label: "Historico", icon: Icon(Icons.history)),
            ])
      ]),
    ));
  }
}
