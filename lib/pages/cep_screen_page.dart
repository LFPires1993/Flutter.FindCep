import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../fragments/adress_display_fragment.dart';

final client = http.Client();

Future<Map> getAdress(String cep) async {
  final String url = 'https://viacep.com.br/ws/$cep/json';

  http.Response response = await client.get(Uri.parse(url));

  return convert.jsonDecode(response.body);
}

class CepScreenPage extends StatelessWidget {
  final String cep;

  CepScreenPage({super.key, required this.cep});

  final Color primaryColor = Colors.yellowAccent;

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
      body: FutureBuilder<Map>(
        future: getAdress(this.cep),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(
                  strokeAlign: 10,
                  strokeWidth: 15,
                  strokeCap: StrokeCap.round,
                  color: Colors.yellowAccent,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erro ao carregar dados: ${snapshot.error}',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.yellowAccent,
                    ),
                  ),
                );
              } else {
                return AdressDisplayFragment(data: snapshot.data!);
              }
          }
        },
      ),
    );
  }
}
