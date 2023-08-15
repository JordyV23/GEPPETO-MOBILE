import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geppetto_mobile/presentation/utils/dialog_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConversionScreen extends StatelessWidget {
  const ConversionScreen({Key? key});

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
      body: ConversionForm(),
    );
  }
}

class ConversionForm extends StatefulWidget {
  @override
  _ConversionFormState createState() => _ConversionFormState();
}

class _ConversionFormState extends State<ConversionForm> {
  String initialValue = '2';
  String finalValue = '2';
  String inputValue = '0';
  String result = '';
  String errorMessage = '';
  bool isLoading = false;

  void calculateResult() async {
    setState(() {
      isLoading = true;
    });

    final apiUrl = "https://api-python-matematicas.onrender.com/api/cbase/";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "_num": inputValue,
            "base_from": initialValue,
            "base_to": finalValue,
          },
        ),
      );
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['Status'] == "True") {
        String conversionResult = jsonResponse['Numero'];

        setState(() {
          result = conversionResult;
          errorMessage = ''; // Clear any previous error messages
        });
      } else {
        setState(() {
          errorMessage = jsonResponse['Mensaje'];
        });
        DialogUtils.showErrorDialog(context, errorMessage);
      }
    } catch (e) {
      setState(() {
        errorMessage =
            'Algo salió mal al hacer la solicitud, intenta más tarde...';
      });
      DialogUtils.showErrorDialog(context, errorMessage);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
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
            decoration: const InputDecoration(
              labelText: 'Valor a convertir',
              filled: true,
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            dropdownColor: theme.primary,
            style: const TextStyle(color: Colors.black),
            value: initialValue,
            onChanged: (value) {
              setState(() {
                initialValue = value!;
              });
            },
            items: List.generate(
              61,
              (index) => DropdownMenuItem<String>(
                value: (index + 2).toString(),
                child: Text('${index + 2}'),
              ),
            ),
            decoration: const InputDecoration(
              labelText: 'Base inicial',
              filled: true,
              labelStyle: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            dropdownColor: theme.primary,
            style: const TextStyle(color: Colors.black),
            value: finalValue,
            onChanged: (value) {
              setState(() {
                finalValue = value!;
              });
            },
            items: List.generate(
              61,
              (index) => DropdownMenuItem<String>(
                value: (index + 2).toString(),
                child: Text('${index + 2}'),
              ),
            ),
            decoration: const InputDecoration(
              labelText: 'Base final',
              filled: true,
              labelStyle: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            style: const TextStyle(color: Colors.black),
            readOnly: true,
            controller: TextEditingController(text: result),
            decoration: const InputDecoration(
              labelText: 'Resultado',
              filled: true,
            ),
          ),
          if (errorMessage.isNotEmpty)
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isLoading ? null : calculateResult,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(
                  30.0),
            ),
            child:const Text('Calcular', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 16 ), ),
          ),
          if (isLoading)
            const CircularProgressIndicator(), // Mostrar animación de carga
        ],
      ),
    );
  }
}
