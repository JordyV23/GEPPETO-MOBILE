import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geppetto_mobile/presentation/utils/dialog_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SolverScreen extends StatelessWidget {
  const SolverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/logo-gpto.svg',
              width: 45,
            ),
            const Text(
              "GEPPETTO",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SolverForm(),
    );
  }
}

class SolverForm extends StatefulWidget {
  @override
  _SolverFormState createState() => _SolverFormState();
}

class _SolverFormState extends State<SolverForm> {
  String inputValue = '0';
  String result = '';
  String errorMessage = '';
  bool isLoading = false;

  void calculateResult() async {
    setState(() {
      isLoading = true;
    });

    final apiUrl = "https://api-python-matematicas.onrender.com/api/numbes/";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "cifras": inputValue,
          },
        ),
      );

      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['Status'] == "True") {
        String conversionResult = jsonResponse['solucion'];

        setState(() {
          result = conversionResult;
          errorMessage = ''; // Clear any previous error messages
        });
      } else {
        setState(() {
          errorMessage = '${jsonResponse['Mensaje']} 🤔';
        });
        DialogUtils.showErrorDialog(context, errorMessage);
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Algo salió mal al hacer la solicitud';
      });
      DialogUtils.showErrorDialog(context, errorMessage);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            style: const TextStyle(color: Colors.black),
            onChanged: (value) {
              setState(() {
                inputValue = value;
              });
            },
            decoration: const InputDecoration(labelText: 'Valor a convertir'),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 10),
          TextFormField(
            style: const TextStyle(color: Colors.black),
            readOnly: true,
            controller: TextEditingController(text: result),
            decoration: const InputDecoration(labelText: 'Resultado'),
          ),
          if (errorMessage.isNotEmpty)
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isLoading ? null : calculateResult,
            child: const Text('Calcular'),
          ),
          if (isLoading)
            const CircularProgressIndicator(), // Mostrar animación de carga
        ],
      ),
    );
  }
}
