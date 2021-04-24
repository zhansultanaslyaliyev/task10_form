import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterFormPage extends StatefulWidget {
  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {

  bool _hidePass = true;

  final _formKey = GlobalKey <FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();

  List<String> _countries = ['Russia', 'Kazakhstan', 'China', 'UAE', 'UK', 'USA'];
  String _selectedCountry;


  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
        labelText: 'Full name *',
          prefixIcon: Icon(Icons.person),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.lightGreenAccent, width: 2.0),
        ),
            ),
          validator: _validateName,
        ),
            SizedBox(height: 10),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone number *',
                prefixIcon: Icon(Icons.call),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.lightGreenAccent, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
               // FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'), allow: true)
              ],
              validator: (value) => _validatePhoneNumber(value) ? null
                  : 'Phone number must be entered as (XXX)XXX-XXXX',
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
                decoration: InputDecoration(labelText: 'Email Address *',
                icon: Icon(Icons.mail),
                ),
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.map),
              ),
              items: _countries.map((country) {
                return DropdownMenuItem(
                  child: Text(country),
                  value: country,
                );
              }) .toList(),
              onChanged: (data) {
                print(data);
                setState(() {
                  _selectedCountry = data;
                });
              },
              value: _selectedCountry,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _storyController,
                decoration: InputDecoration(labelText: 'Life Story *',
                border: OutlineInputBorder(),
                ),
              maxLines: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: _hidePass,
                maxLength: 24,
                decoration: InputDecoration(labelText: 'Password *',
                suffixIcon: IconButton(
                  icon: Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
                  icon: Icon(Icons.security),
                ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _confirmPassController,
              obscureText: _hidePass,
              maxLength: 24,
                decoration: InputDecoration(labelText: 'Confirm password *',
                  icon: Icon(Icons.border_color),
                ),
            ),
            SizedBox(height: 15),
            RaisedButton(
              onPressed: _submitForm,
              color: Colors.green,
              child: Text('Submit', style: TextStyle(color: Colors.white),
            ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      print('Form is valid');
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Story: ${_storyController.text}');
    }
  }

  String _validateName(String value) {
    final _nameExp = RegExp(r'^[A-Za-z]');
    if(value.isEmpty) {
      return 'Name is required';
    } else if(!_nameExp.hasMatch(value)) {
      return 'Please enter alphabetical characters';
    } else {
      return null;
    }
  }
  bool _validatePhoneNumber(String input) {
    final _phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return _phoneExp.hasMatch(input);
  }
  String _validateEmail(String value) {
    if(value.isEmpty) {
      return 'Email cannot be empty';
    } else if(!_emailController.text.contains('@')) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }
}
