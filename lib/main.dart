import 'package:flutter/material.dart';

void main() {
  runApp(IMCCalculator());
}

class IMCCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remover faixa debug
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: IMCForm(),
        ),
      ),
    );
  }
}

class IMCForm extends StatefulWidget {
  @override
  _IMCFormState createState() => _IMCFormState();
}

class _IMCFormState extends State<IMCForm> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  final _nomeController = TextEditingController(); // Novo campo para o nome
  final _raController = TextEditingController(); // Novo campo para o RA
  String _resultado = "";
  String _generoSelecionado = "Masculino";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Dupla:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Nome: ENRICO FERREIRA DOS SANTOS \nRA: 1431432312012',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Nome: MURILO MARTINS ALVES \nRA: 1431432312004',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField(
            value: _generoSelecionado,
            items: ['Masculino', 'Feminino']
                .map((genero) => DropdownMenuItem(
                      value: genero,
                      child: Text(genero),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _generoSelecionado = value.toString();
              });
            },
          ),
          TextFormField(
            controller: _pesoController,
            decoration: InputDecoration(
              labelText: 'Insira seu peso em quilogramas',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira seu peso.';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _alturaController,
            decoration: InputDecoration(
              labelText: 'Insira sua altura em metros',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira sua altura.';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                double peso = double.parse(_pesoController.text!);
                double altura = double.parse(_alturaController.text!);
                double imc = _calcularIMC(peso, altura, _generoSelecionado);

                setState(() {
                  _resultado =
                      'Seu IMC é: ${imc.toStringAsFixed(2)}\nCategoria: ${_calcularCategoria(imc, _generoSelecionado)}';
                });
              }
            },
            child: Text('Calcular'),
          ),
          SizedBox(height: 16),
          Text(
            _resultado,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  double _calcularIMC(double peso, double altura, String genero) {
    // Lógica de cálculo do IMC
    if (genero == "Masculino") {
      return peso / (altura * altura);
    } else {
      return peso / (altura * altura);
    }
  }

  String _calcularCategoria(double imc, String genero) {
    // Lógica de determinação da categoria de peso
    if (genero == "Masculino") {
      if (imc < 20.7) {
        return 'Abaixo do peso';
      } else if (imc >= 20.7 && imc <= 26.4) {
        return 'Peso ideal';
      } else if (imc >= 26.5 && imc <= 27.8) {
        return 'Pouco acima do peso';
      } else if (imc >= 27.9 && imc <= 31.1) {
        return 'Acima do peso';
      } else {
        return 'Obesidade';
      }
    } else {
      if (imc < 19.1) {
        return 'Abaixo do peso';
      } else if (imc >= 19.1 && imc <= 25.8) {
        return 'Peso ideal';
      } else if (imc >= 25.9 && imc <= 27.3) {
        return 'Pouco acima do peso';
      } else if (imc >= 27.4 && imc <= 32.3) {
        return 'Acima do peso';
      } else {
        return 'Obesidade';
      }
    }
  }

  @override
  void dispose() {
    // Dispose dos controllers
    _pesoController.dispose();
    _alturaController.dispose();
    _nomeController.dispose();
    _raController.dispose();
    super.dispose();
  }
}
