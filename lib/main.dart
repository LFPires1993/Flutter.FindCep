import 'package:consulta_cep/pages/cep_screen_page.dart';
import 'package:flutter/material.dart';

main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final OutlineInputBorder inputBorderStyle = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.yellowAccent,
    ),
  );

  final Color primaryColor = Colors.yellowAccent;
  final TextEditingController cepController = TextEditingController();
  String? textFieldMessageError;
  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Consulta CEP'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: validateCep,
              cursorColor: primaryColor,
              keyboardType: TextInputType.number,
              controller: cepController,
              style: TextStyle(color: primaryColor, fontSize: 20),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabledBorder: inputBorderStyle,
                focusedBorder: inputBorderStyle,

                helperText: 'Ex: 90352698',
                helperStyle: TextStyle(color: primaryColor),
                labelText: 'CEP',
                labelStyle: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                ),
                errorText: textFieldMessageError,
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                ),

              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.grey[800],
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),),
              onPressed: isButtonEnabled ? findCep : null,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_location_rounded,
                    color: Colors.black,
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Pesquisar CEP',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  validateCep(String cep) {
    if(cep.isEmpty) {
      setState(() {
        textFieldMessageError = null;
        isButtonEnabled = false;
      });
    } else if (cep.length != 8) {
      setState(() {
        isButtonEnabled = false;
        textFieldMessageError =
            'O valor informado não corresponde a um CEP válido';
      });
    } else {
      setState(() {
        isButtonEnabled = true;
        textFieldMessageError = null;
      });
    }
  }

  findCep() {
    final cep = cepController.text.toString();
    Navigator.push(context, MaterialPageRoute(builder: (context) => CepScreenPage(cep: cep)));
  }
}
