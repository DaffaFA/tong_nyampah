import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tongnyampah/models/User.dart';
import 'package:tongnyampah/services/database.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey _formKey = GlobalKey();

  String kelas;
  String nama;
  TextEditingController _namaController = TextEditingController();
  TextEditingController _kelasController = TextEditingController();

  Future<void> getUserData(User user) async {
    await user.data.then((onValue) {
      setState(() {
        kelas = onValue.data["classroom"];
        nama = onValue.data["name"];
      });
    }).whenComplete(() {
      setState(() {
        _namaController = TextEditingController(text: nama.toString());
        _kelasController = TextEditingController(text: kelas.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
    getUserData(_user);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                margin: EdgeInsets.only(top: 38.0),
                child: TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(
                      labelText: 'Full Name', border: OutlineInputBorder()),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: TextFormField(
                  controller: _kelasController,
                  decoration: InputDecoration(
                      labelText: 'Classroom', border: OutlineInputBorder()),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () async {
                    DatabaseService(uid: _user.uid).editProfile(
                      name: _namaController.text,
                      classroom: _kelasController.text,
                    );
                  },
                  color: Colors.black,
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
