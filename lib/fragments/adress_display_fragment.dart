import 'package:flutter/material.dart';

class AdressDisplayFragment extends StatelessWidget {
  final Map data;

  AdressDisplayFragment({super.key, required this.data});

  final TextStyle fieldsStyle = const TextStyle(
    color: Colors.yellowAccent,
    fontSize: 25
  );

  final TextStyle valuesStyle = const TextStyle(
      color: Colors.white,
      fontSize: 25,
      decoration: TextDecoration.underline
  );

  @override
  Widget build(BuildContext context) {
    if(data['erro'] != null) {
      return const Center(
        child: Text(
          'CEP não encontrado!',
          style: TextStyle(
            fontSize: 28,
            color: Colors.yellowAccent,
          ),
        ),
      );
    } else{ return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [Text('CEP: ', style: fieldsStyle,), Text(this.data['cep'], style: valuesStyle,)],
            ),
            SizedBox(height: 10),
            Row(
              children: [Text('Rua: ', style: fieldsStyle,), Text(this.data['logradouro'], style: valuesStyle,)],
            ),
            SizedBox(height: 10),
            Row(
              children: [Text('Bairro: ', style: fieldsStyle,), Text(this.data['bairro'], style: valuesStyle,)],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Cidade/UF: ', style: fieldsStyle,),
                Text('${this.data['localidade']} - ${this.data['uf']}', style: valuesStyle,)
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [Text('DDD: ', style: fieldsStyle,), Text(this.data['ddd'], style: valuesStyle,)],
            ),
          ],
        ),
      ),
    );}
  }
}
