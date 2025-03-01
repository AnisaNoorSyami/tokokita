import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';

class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({Key? key, this.produk}): super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();

}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  bool _isLoading = false;
  String judul = "Tambah Prduk";
  String tomboSubmit = "Simpan";

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if(widget.produk != null) {
      setState(() {
        judul = "Ubah Produk";
        tomboSubmit = "Ubah";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
        _namaProdukTextboxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextboxController.text = widget.produk!.hargaProduk.toString();
      });
    } else {
      judul = "Tambah Produk";
      tomboSubmit = "Simpan";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeProdukTextField(),
                _namaProdukTextField(),
                _hargaProdukTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kode Produk"),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if(value!.isEmpty) {
          return "Kode Produk harus diisi";
        }
        return null;
      }
    );
  }

  Widget _namaProdukTextField() {
    return TextFormField(
        decoration: const InputDecoration(labelText: "Nama Produk"),
        keyboardType: TextInputType.text,
        controller: _namaProdukTextboxController,
        validator: (value) {
          if(value!.isEmpty) {
            return "Nama Produk harus diisi";
          }
          return null;
        }
    );
  }

  Widget _hargaProdukTextField() {
    return TextFormField(
        decoration: const InputDecoration(labelText: "Harga"),
        keyboardType: TextInputType.text,
        controller: _hargaProdukTextboxController,
        validator: (value) {
          if(value!.isEmpty) {
            return "Harga Produk harus diisi";
          }
          return null;
        }
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
        onPressed: () {
          var validate = _formKey.currentState!.validate();
        },
        child: Text(tomboSubmit)
    );
  }
}