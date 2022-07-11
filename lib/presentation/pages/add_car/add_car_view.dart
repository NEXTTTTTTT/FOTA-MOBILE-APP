import 'package:flutter/material.dart';


class AddCarView extends StatefulWidget {
  const AddCarView({Key? key}) : super(key: key);

  @override
  State<AddCarView> createState() => _AddCarViewState();
}

class _AddCarViewState extends State<AddCarView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('add car')),
    );
  }
}
