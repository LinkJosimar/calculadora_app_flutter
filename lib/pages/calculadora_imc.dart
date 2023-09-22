import 'package:flutter/material.dart';
import '../model/imc.dart';
import '../model/resultados_imc.dart';

class CalcImcPage extends StatefulWidget {
  final Function(ResultadosImc) novoItemAdicionado;
  const CalcImcPage({super.key, required this.novoItemAdicionado});

  @override
  State<CalcImcPage> createState() => _CalcImcPageState();
}

class _CalcImcPageState extends State<CalcImcPage> {
  var alturaCtrl = TextEditingController();
  var pesoCtrl = TextEditingController();
  String classificacaoIMC = "";
  String imcFixed = "";
  var imc = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              height: 90,
              color: const Color.fromARGB(255, 52, 212, 37),
              child: const Text("Ja viu seu IMC hoje?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )),
            ),
            const SizedBox(height: 30),
            Row(children: [
              Expanded(child: Container()),
              const Expanded(
                  child: Icon(
                Icons.height,
                size: 50,
              )),
              Expanded(
                flex: 3,
                child: TextField(
                    controller: alturaCtrl,
                    style: const TextStyle(fontSize: 25),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Altura em cm")),
              ),
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("cm",
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              )),
              Expanded(child: Container()),
            ]),
            const SizedBox(height: 30),
            Row(children: [
              Expanded(child: Container()),
              const Expanded(
                  child: Icon(
                Icons.monitor_weight,
                size: 50,
              )),
              Expanded(
                flex: 3,
                child: TextField(
                    controller: pesoCtrl,
                    style: const TextStyle(fontSize: 25),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Peso em kg")),
              ),
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("kg",
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              )),
              Expanded(child: Container()),
            ]),
            const SizedBox(height: 30),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 60),
                height: 40,
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {
                        if (pesoCtrl.text.trim() == "" ||
                            alturaCtrl.text.trim() == "") {
                          debugPrint("Peso e altura são obrigatórios");
                          imcFixed = "ERRO";
                          classificacaoIMC = "ERRO";
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Valores para peso e/ou altura incorretos",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          setState(() {});
                        } else {
                          var pesoDouble = double.parse(pesoCtrl.text);
                          var alturaDouble = double.parse(alturaCtrl.text);
                          // calculo o IMC
                          imc = Imc.calculoIMC(pesoDouble, alturaDouble);
                          // faço a classificação
                          classificacaoIMC = Imc.classificacaoIMC(imc);
                          // informo na caixa inicial o valor do IMC
                          imcFixed = imc.toStringAsFixed(2);
                          // guardo oa dados no ResultadoImc
                          final novoItem = (ResultadosImc(
                            peso: pesoDouble,
                            altura: alturaDouble,
                            imc: imc,
                            classificacao: classificacaoIMC,
                            data: DateTime.now().toString(),
                          ));
                          // chama a função para adicionar o item armazenado
                          widget.novoItemAdicionado(novoItem);
                          setState(() {});
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 52, 212, 37)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Calcular",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                )),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(flex: 2, child: Container()),
                const Expanded(
                    flex: 2,
                    child: Text(
                      "Seu IMC:",
                      style: TextStyle(fontSize: 20),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: const Color.fromARGB(255, 0, 74, 179),
                          )),
                      child: Text(
                        // imc calculado
                        imcFixed,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(flex: 2, child: Container()),
              ],
            ),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(flex: 2, child: Container()),
              const Expanded(
                  flex: 3,
                  child: Text(
                    "STATUS:",
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                  flex: 3,
                  // classificação do IMC
                  child: Text(classificacaoIMC)),
              Expanded(
                  flex: 2,
                  child: InkWell(
                      onTap: () {
                        debugPrint("clicou");
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            context: context,
                            builder: (BuildContext bc) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Escala de IMC",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: Image.asset(
                                        "lib/images/escala_imc.png",
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: const Icon(
                        Icons.info_rounded,
                        size: 25,
                      ))),
            ])
          ],
        )
      ],
    ));
  }
}
