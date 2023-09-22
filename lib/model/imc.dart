import 'resultados_imc.dart';

class Imc {
  double? _peso;
  double? _altura;
  List<ResultadosImc> resultados = [];

  Imc(double peso, double altura) {
    _peso = peso;
    _altura = altura;
  }

  double? get peso {
    return _peso;
  }

  set peso(double? novoPeso) {
    _peso = novoPeso;
  }

  double? get altura {
    return _altura;
  }

  set altura(double? novaAltura) {
    _altura = novaAltura;
  }

  static double calculoIMC(double peso, double altura) {
    double alturaMetros = altura;
    double imc = peso / (alturaMetros * alturaMetros);
    return imc;
  }

  static String classificacaoIMC(double imc) {
    if (imc < 18.5) {
      return "Abaixo do peso";
    } else if (imc >= 18.5 && imc <= 24.9) {
      return "Peso normal";
    } else if (imc >= 25 && imc <= 29.9) {
      return "Sobrepeso";
    } else if (imc >= 30 && imc <= 34.9) {
      return "Obesidade grau 1";
    } else if (imc >= 35 && imc <= 39.9) {
      return "Obesidade grau 2";
    } else {
      return "Obesidade grau 3";
    }
  }

  void adicionarHistorico(double imc, String classificacao) {
    double imcVar = imc;
    String classificacaoVar = classificacao;
    String data = DateTime.now().toString();

    ResultadosImc item = ResultadosImc(
      peso: _peso!,
      altura: _altura!,
      imc: imcVar,
      classificacao: classificacaoVar,
      data: data,
    );

    resultados.add(item);
  }
}
