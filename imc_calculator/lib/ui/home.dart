import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'result.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetCampos() {
    pesoController = TextEditingController();
    alturaController = TextEditingController();
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetCampos,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person, size: 120, color: Colors.blueAccent),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.blueAccent)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueAccent, fontSize: 25),
                  controller: pesoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira seu peso!";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (m)",
                      labelStyle: TextStyle(color: Colors.blueAccent)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueAccent, fontSize: 25),
                  controller: alturaController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira sua altura!";
                    } else {
                      return null;
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calcular();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      style: ElevatedButton.styleFrom(
                          //  primary: Colors.blue,
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  void _calcular() {
    String _texto = "";
    String _imagem = "";

    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text);

    double imc = peso / (altura * altura);
    if (imc < 18.6) {
      _texto = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      _imagem = "images/thin.png";
    } else if (imc >= 18.6 && imc < 24.9) {
      _texto = "Peso ideal (${imc.toStringAsPrecision(4)})";
      _imagem = "images/shape.png";
    } else if (imc >= 24.9 && imc < 29.9) {
      _texto = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      _imagem = "images/fat.png";
    } else if (imc >= 29.9 && imc < 34.9) {
      _texto = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      _imagem = "images/fat.png";
    } else if (imc >= 34.9 && imc < 39.9) {
      _texto = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      _imagem = "images/fat.png";
    } else if (imc >= 40) {
      _texto = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      _imagem = "images/fat.png";
    }

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Result(_imagem, _texto)));
  }
}
