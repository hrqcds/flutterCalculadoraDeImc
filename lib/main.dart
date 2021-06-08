import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora de IMC",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _info = "informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetField() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _info = "informe seus dados";
    });
  }

  void calcular() {
    setState(() {
      double peso = double.parse(weightController.text);
      double altura = double.parse(heightController.text) / 100;
      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        _info = "Abaixo do Peso: ${imc.toStringAsPrecision(3)}";
      } else if (imc < 25) {
        _info = "Peso normal: ${imc.toStringAsPrecision(3)}";
      } else {
        _info = "Acima do Peso: ${imc.toStringAsPrecision(3)}";
      }

      weightController.text = "";
      heightController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _resetField();
                })
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 120,
                    color: Colors.green,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (KG)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: weightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu peso";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (CM)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua altura";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: 50,
                      child: (ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            calcular();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                      )),
                    ),
                  ),
                  Text(
                    "$_info",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                  )
                ],
              ),
            )));
  }
}
