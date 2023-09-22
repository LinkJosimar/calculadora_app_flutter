import 'package:flutter/material.dart';

import '../model/resultados_imc.dart';

class ResultadosPage extends StatefulWidget {
  final List<ResultadosImc> resultados;
  const ResultadosPage({super.key, required this.resultados});

  @override
  State<ResultadosPage> createState() => _ResultadosPageState();
}

class _ResultadosPageState extends State<ResultadosPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.resultados.length,
      itemBuilder: (context, index) {
        final item = widget.resultados[index];
        return ListTile(
          title: Text('Peso: ${item.peso} kg'),
          subtitle: Text(
              'Altura: ${item.altura} cm\nIMC: ${item.imc.toStringAsFixed(2)}\nClassificação: ${item.classificacao}\nData: ${item.data}'),
        );
      },
    );
  }
}
